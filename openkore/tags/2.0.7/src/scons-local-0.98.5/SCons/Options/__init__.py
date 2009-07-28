#
# Copyright (c) 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008 The SCons Foundation
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
# KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

__revision__ = "src/engine/SCons/Options/__init__.py 3057 2008/06/09 22:21:00 knight"

__doc__ = """Place-holder for the old SCons.Options module hierarchy

This is for backwards compatibility.  The new equivalent is the Variables/
class hierarchy.  These will have deprecation warnings added (some day),
and will then be removed entirely (some day).
"""

import SCons.Variables

from BoolOption import BoolOption  # okay
from EnumOption import EnumOption  # okay
from ListOption import ListOption  # naja
from PackageOption import PackageOption # naja
from PathOption import PathOption # okay

class Options(SCons.Variables.Variables):

    def AddOptions(self, *args, **kw):
        return apply(SCons.Variables.Variables.AddVariables,
                     (self,) + args,
                     kw)

    def UnknownOptions(self, *args, **kw):
        return apply(SCons.Variables.Variables.UnknownVariables,
                     (self,) + args,
                     kw)

    def FormatOptionHelpText(self, *args, **kw):
        return apply(SCons.Variables.Variables.FormatVariableHelpText,
                     (self,) + args,
                     kw)
