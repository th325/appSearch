

# Table of Contents
1. [Example](#example)
2. [Example2](#example2)
3. [Third Example](#third-example)
4. - [Section One](#section-one)
     - [Subsection OneToOne](#subsection-onetoone)


265


77
I started to use mardown to take notes.

I use marked to view my markdown notes and its beautiful.

But as my notes get longer I find it difficult to find what I want.

I know markdown can create tables, but is it able to create table of contents, that jumps to sections, or define page sections in markdown?

Alternatively, are there markdown readers/editors that could do such things. Search would be good feature to have too.

In short, I want to make it my awesome note taking tool and functions much like writing a book etc.

markdown
shareimprove this question
asked Aug 14 '12 at 8:10

resting
4,3201313 gold badges4242 silver badges6666 bronze badges
2
if you want to use a javascript/node.js tool, try marked-toc – jonschlinkert Feb 5 '14 at 14:14
@jonschlinkert You should submit that as an answer! Currently, the answers only suggest tools that are either not free or Python. Not really a great set of choices. – Domi Aug 2 '14 at 13:36
done, and thank you! – jonschlinkert Aug 3 '14 at 7:27
5
I should maybe mention that in LaTeX this is achieved with \tableofcontents. If the wheel is going to be reinvented, it would be preferable to copy the good parts. – Eero Aaltonen Dec 3 '15 at 16:10 
1
GitHub markdown: stackoverflow.com/questions/9721944/… – Ciro Santilli 新疆改造中心996ICU六四事件 Jan 5 '17 at 10:21
show 1 more comment
31 Answers
active oldest votes
1 2 next
 
25

MultiMarkdown Composer does seem to generate a table of contents to assist while editing.

There might also be the one or the other library, who can generate TOCs: see Python Markdown TOC Extension.

shareimprove this answer
edited Feb 4 '18 at 20:24
answered Aug 19 '12 at 23:38

mxro
2,58411 gold badge2222 silver badges3131 bronze badges
13
MultiMarkdown Composer is MacOS only – chmike Aug 19 '15 at 8:46
1
Working Python Markdown TOC link: python-markdown.github.io/extensions/toc – John Feb 4 '18 at 15:01
1
The app isn't available in the UK region. – kenorb Jul 3 at 13:29
add a comment
 
294

You can give this a try.

# Table of Contents
1. [Example](#example)
2. [Example2](#example2)
3. [Third Example](#third-example)
4. [Fourth Example](#fourth-examplehttpwwwfourthexamplecom)


## Example
## Example2
## Third Example
## [Fourth Example](http://www.fourthexample.com) 
shareimprove this answer
edited Jun 23 at 22:56

baybora.oren
2,97633 gold badges2727 silver badges2929 bronze badges
answered Jan 14 '15 at 22:22

Rick
6,79722 gold badges3434 silver badges3535 bronze badges
7
tell me in which way anchors did work, written in this way.. – Luca Davanzo Apr 3 '15 at 13:24
It doesn't work with MarkdownPad2 (Windows) – chmike Aug 19 '15 at 8:43 
8
The 3rd example above does not work. ## Example ## "Example2" ## Third Example<a name="third-example" /> is the only way I could get it to swallow spaces so far. Surely the 3rd tag would be interpreted as - #Third - followed by a space - then the word Example - in your snippet above? Hyphens do not work at all. Thanks – twobob Jul 9 '16 at 16:41 
4
Works fine in RStudio. Just want to add that the German umlauts e.g. ü need to be written without umlaut in the anchor i.e. 1. [Einführung](#einfuhrung) – steinbock Sep 23 '16 at 12:44 
4
Anchors are not automatically created for headings in Bitbucket v4.5.2 – Mike Rylander Oct 7 '16 at 16:36
show 4 more comments
 
167

Here's a useful method. Should produce clickable references in any MarkDown editor.

# Table of contents
1. [Introduction](#introduction)
2. [Some paragraph](#paragraph1)
    1. [Sub paragraph](#subparagraph1)
3. [Another paragraph](#paragraph2)

## This is the introduction <a name="introduction"></a>
Some introduction text, formatted in heading 2 style

## Some paragraph <a name="paragraph1"></a>
The first paragraph text

### Sub paragraph <a name="subparagraph1"></a>
This is a sub paragraph, formatted in heading 3 style

## Another paragraph <a name="paragraph2"></a>
The second paragraph text
Produces:

Table of contents
Introduction
Some paragraph
Sub paragraph
Another paragraph
This is the introduction
Some introduction text, formatted in heading 2 style

Some paragraph
The first paragraph text

Sub paragraph
This is a sub paragraph, formatted in heading 3 style

Another paragraph
The second paragraph text

shareimprove this answer
edited May 23 '17 at 12:26

Community♦
111 silver badge
answered Oct 30 '15 at 9:53

Tum
3,11522 gold badges1717 silver badges1919 bronze badges
14
I like to put the anchor tag on the line above the heading so when the link is clicked the heading shows up on the page. – mgarey Apr 5 '17 at 0:27
4
This was the only useful one for me. With long titles, it's impossible to do it without anchor tags. – Matt Fletcher Dec 12 '17 at 12:53
add a comment

27

For the Visual Studio Code users, a good idea is use the Markdown TOC plugin.

To install it, launch the VS Code Quick Open (Ctrl+P), paste the following command, and press enter.

ext install markdown-toc
And to generate the TOC, open the command palette (Control/⌘+Shift+P) and select the Markdown TOC:Insert/Update option or use Ctrl+MT.

shareimprove this answer
edited Jul 3 at 13:33

kenorb
80k3434 gold badges447447 silver badges461461 bronze badges
answered May 10 '17 at 18:50

coderade
4,03133 gold badges2424 silver badges4141 bronze badges
3
Note: I just found that using stock VSCode you can make markdown links to headers: [Section Foo](#foo-header-title), and it even works outside of preview mode (i.e. in the plain markdown). – kitsu.eb Jul 10 '17 at 15:26
another alternative for VSCode is vscode-markdown which has multiple features, ToC included – Ciprian Tomoiagă Oct 26 '18 at 12:23
add a comment

25

You could try this ruby script to generate the TOC from a markdown file.

 #!/usr/bin/env ruby

require 'uri'

fileName = ARGV[0]
fileName = "README.md" if !fileName

File.open(fileName, 'r') do |f|
  inside_code_snippet = false
  f.each_line do |line|
    forbidden_words = ['Table of contents', 'define', 'pragma']
    inside_code_snippet = !inside_code_snippet if line.start_with?('```')
    next if !line.start_with?("#") || forbidden_words.any? { |w| line =~ /#{w}/ } || inside_code_snippet

    title = line.gsub("#", "").strip
    href = URI::encode title.gsub(" ", "-").downcase
    puts "  " * (line.count("#")-1) + "* [#{title}](\##{href})"
  end
end
shareimprove this answer
edited Jul 4 at 12:36

tuoxie007
1,1541111 silver badges1010 bronze badges
answered Mar 2 '14 at 17:45

albertodebortoli
89611 gold badge1010 silver badges1616 bronze badges
Great! Just a note, may want to add ifndef, include, and endif, among other preprocessor directives, to the forbidden words list. Also, defining the list out of the scope of the loop avoids having to reinstantiate it with each iteration. Also, this will pick up comments of any language that uses # comment syntax, Ruby included, which is not good. I am willing to edit if you'd like. However this is a great start and worked well for my purposes. Thanks so much! – Jeffrey Klein Mar 16 '16 at 23:18
This only works with atx headings (i.e those that start with #), not with setext ones (underlined). – gozzilli Aug 10 '16 at 13:49
thanks for this, if you are using this for redcarpet on rails, you should go with title.parameterize for the href, thanks! – Alexis Sep 11 '16 at 22:29
add a comment

23

# Table of Contents
1. [Example](#example)
2. [Example2](#example2)
3. [Third Example](#third-example)

## Example [](#){name=example}
## Example2 [](#){name=example2}
## [Third Example](#){name=third-example}

### Example

### Example2
ADDDDDDDDSA
S
S
S
AS
AS
SA
AS
AS
### Third Example
