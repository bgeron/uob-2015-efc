r"""
Skip directive, by Bram Geron.

Adds a bit of vertical space.

Usage:

    .. skip:: big

This adds a \bigskip in the LaTeX, and a vertical space in the HTML. By HTML
standards, the space is not very big.
"""

from docutils import nodes
from docutils.parsers.rst import Directive
import docutils.parsers.rst.directives as directives
from sphinx.errors import SphinxError

def setup(app):
    app.add_node(skip,
                 html=(visit_skip_html, depart_skip_html),
                 latex=(visit_skip_tex, depart_skip_tex))
    app.add_directive('skip', SkipDirective)

    return {
        'version': "0.1",
        'parallel_read_safe': True,
        'parallel_write_safe': True,
    }

class skip(nodes.General, nodes.Element):
    pass

class SkipError(SphinxError):
    pass

class SkipDirective(Directive):
    
    has_content = True

    option_spec = {
    }

    def run(self):
        if self.content.data == []:
            raise self.error("missing skip size")
        elif not isinstance(self.content.data, list) or len(self.content.data) != 1:
            raise self.error("skip size decl not recognised: " + repr(self.content.data))

        size = self.content.data[0]

        if size in ['para', 'big', 'xxlarge']:
            return [skip(size=size)]
        else:
            raise self.error("skip size not recognised: " + repr(size))



def visit_skip_tex(self, node):
    if node['size'] == 'para':
        self.body.append("\n\n")
    elif node['size'] == 'big':
        self.body.append("\n\n\\bigskip\n\n")
    elif node['size'] == 'xxlarge':
        self.body.append("\n\n\\vfill\n\n")
    else:
        raise SkipError("cannot render skip size %r to latex"
            % (node['size'],))

def depart_skip_tex(self, node):
    pass

def visit_skip_html(self, node):
    if node['size'] in ['para']:
        pass # HTML already breaks enough paragraphs
    elif node['size'] in ['big', 'xxlarge']:

        self.body.append(
            self.starttag(node, 'div', **{'class': 'skip-%s' % (node['size'],)}))
        self.body.append("</div>")

    else:
        raise SkipError("cannot render skip size %s to HTML"
            % (node['size'],))


def depart_skip_html(self, node):
    pass
