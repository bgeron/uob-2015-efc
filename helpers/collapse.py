# -*- coding: utf-8 -*-
"""
    Collapse directive.

    :copyright: Copyright 2014 by Bram Geron.
    :license: BSD 3-clause.
"""

from docutils import nodes
from docutils.nodes import paragraph, emphasis
import docutils.parsers.rst.directives.admonitions
from docutils.parsers.rst import Directive, directives
from docutils.parsers.rst.roles import set_classes

" ------- SETUP ------ "

def setup(app):

    # * When rendering a collapse node in HTML, add certain HTML tags, then
    #   render the children.
    # * When rendering a collapse node elsewhere, just render its children.
    html_actions = (visit_collapse_html, depart_collapse_html)
    other_actions = (passthrough, passthrough)
    # * When rendering a replacement in HTML, ignore it.
    # * When rendering a replacement elsewhere
    replacement_html_actions = (visit_skipnode, depart_skipnode)
    replacement_other_actions = (visit_skipsiblings, depart_skipsiblings)
    app.add_node(collapse,
        html=html_actions,
        latex=other_actions, text=other_actions,
        man=other_actions, texinfo=other_actions)
    app.add_node(replacement, 
        html=replacement_html_actions,
        latex=replacement_other_actions, text=replacement_other_actions,
        man=replacement_other_actions, texinfo=replacement_other_actions)
    app.add_directive('collapse', CollapseDirective)
    # No directive for replacement, because we only want to create it programmatically.
    app.connect('builder-inited', builder_inited)

    return {
        'version': "0.1",
        'parallel_read_safe': True,
        'parallel_write_safe': True,
    }

def builder_inited(app):
    app.add_stylesheet("collapse-details-polyfill.css")
    app.add_javascript("jquery.details.min.js")
    app.add_javascript("collapse-details-polyfill.js")

" ------- NODES ------ "

class collapse(nodes.Admonition, nodes.Element):

    pass

class replacement(nodes.General, nodes.Element):
    """A node that serves as a replacement in case we're not writing
    to HTML, in a sense similar to the HTML <noframes> element.

    If we're visiting as HTML, we skip this node.

    If we're visiting otherwise, we visit the children and skip the siblings.
    """

" ------- DIRECTIVES ------ "

class CollapseDirective(directives.admonitions.BaseAdmonition):

    node_class = collapse

    def run(self):

        (node,) = super(CollapseDirective, self).run()

        # Add a replacement node with some text.
        replnode = replacement(node.rawsource,
            paragraph(node.rawsource, "", 
                emphasis(node.rawsource, "[ collapsed ]")))
        node.insert(0, replnode)

        return [node]

" ------- VISITOR FUNCTIONS ------ "

def visit_collapse_html(self, node):
    self.body.append(self.starttag(node, 'details'))
    self.body.append(self.starttag(node, 'summary'))
    # self.visit_title(node.title)
    self.body.append("(answer goes here)")
    self.body.append("</summary>")
    self.body.append(self.starttag(node, 'div'))

def depart_collapse_html(self, node):
    self.body.append('</div>')
    self.body.append('</details>')

def passthrough(self, node): pass

def visit_skipnode(self, node):
    raise nodes.SkipNode
def depart_skipnode(self, node): pass

def visit_skipsiblings(self, node): pass
def depart_skipsiblings(self, node):
    raise nodes.SkipSiblings
