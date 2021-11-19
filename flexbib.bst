% Modelo para generar un fichero bbl parametrizado.
% J. M. Mira  11/10/2015
% Version 1.09
% mira@um.es
ENTRY
  { abstract
    address
    author
    booktitle
    chapter
    comment
    doi
    edition
    editor
    eid
    howpublished
    institution
    isbn
    issn
    journal
    key
    hyphenation
    month
    mrnumber
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    smalltitle
    translator
    type
    url
    volume
    year
  }
  {}
  { label extra.label sort.label short.list }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { add.period$ write$
          newline$
          "  \newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output.nonnullb}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { " " write$
          newline$
          "  \newblock " write$
        }
        { output.state before.all =
            'write$
            { " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.checkb}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnullb
  if$
}


FUNCTION {output.checkc}
{ 't :=
  duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {fin.entry} 
{ "\finalpoint{}" * write$
  newline$
  comment missing$
     'skip$
     { "  \bibcomment{" cite$ * "}{" * comment * "}" * write$ newline$ }
  if$
  abstract missing$
     'skip$
     { "  \bibabstract{" cite$ * "}{" * abstract * "}" * write$ newline$ }
  if$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}

FUNCTION {names.end} 
{ duplicate$ empty$
    'skip$
    { "\namesend{}" * }
  if$
}

FUNCTION {date.block}
{
add.blank
}

FUNCTION {null.block}
{
skip$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {non.stop}
{ duplicate$
   "}" * add.period$
   #-1 #1 substring$ "." =
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {like.book.title}
{ duplicate$ empty$
    { pop$ "" }
    {"\bibtitle{\emph{" swap$ * "}}" * } 
  if$
}


FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}

FUNCTION {bib.name.font}
{ duplicate$ empty$
  { pop$ "" }
  { "\bibnamefont{" swap$ * "}" * }
  if$
}

FUNCTION {bib.vol.font}
{ duplicate$ empty$
  { pop$ "" }
  { "\bibvolfont{" swap$ * "}" * }
  if$
}


FUNCTION {bib.fname.font}
{ duplicate$ empty$
  { pop$ "" }
  { "\bibfnamefont{" swap$ * "}" * }
  if$
}

FUNCTION {bib.and.font} { duplicate$ empty$
  { pop$ "" }
  { "\bibandfont{" swap$ * "}" * }
  if$
}

FUNCTION {cite.name.font} { duplicate$ empty$
  { pop$ "" }
  { "\citenamefont{" swap$ * "}" * }
  if$
}

FUNCTION {cite.etal.font} { duplicate$ empty$
  { pop$ "" }
  { "\citetalfont{" swap$ * "}" * }
  if$
}

FUNCTION {cite.and.font} { duplicate$ empty$
  { pop$ "" }
  { "\citeandfont{" swap$ * "}" * }
  if$
}

FUNCTION {bib.in.font} { duplicate$ empty$
  { pop$ "" }
  { "\bibinfont{" swap$ * "}" * }
  if$
}

FUNCTION {tie.or.space.prefix}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$
}

FUNCTION {capitalize}
{ "\capitalize" swap$ * }

FUNCTION {space.word} { " " swap$ * " " * } 

% Dependientes del idioma. Depending on language %%%%%

FUNCTION {bbl.and} { "\bbland{}"}

FUNCTION {bbl.etal}
{ "\bbletal{}"}

FUNCTION {bbl.editors}
{ "\bbleds{}" }

FUNCTION {bbl.editor}
{ "\bbled{}" }

FUNCTION {bbl.edby}
{ "\bbledby{}" }

FUNCTION {bbl.edition}
{ "\bbledition{}" }

FUNCTION {bbl.volume}
{ "\bblvolume{}" }

FUNCTION {bbl.of}
{ "\bblof{}" }

FUNCTION {bbl.number}
{ "\bblnumber{}" }

FUNCTION {bbl.nr}
{ "\bblno{}" }

FUNCTION {bbl.in}
{ "\bblin{}" }

FUNCTION {bbl.pages}
{ "\bblpp{}" }

FUNCTION {bbl.page}
{ "\bblp{}" }

FUNCTION {bbl.chapter}
{ "\bblchapter{}" }

FUNCTION {bbl.techrep}
{ "\bbltechreport{}" }

FUNCTION {bbl.mthesis}
{ "\bblmthesis{}" }

FUNCTION {bbl.phdthesis}
{ "\bblphdthesis{}" }

MACRO {jan} {"\bbljan{}"}

MACRO {feb} {"\bblfeb{}"}

MACRO {mar} {"\bblmar{}"}

MACRO {apr} {"\bblapr{}"}

MACRO {may} {"\bblmay{}"}

MACRO {jun} {"\bbljun{}"}

MACRO {jul} {"\bbljul{}"}

MACRO {aug} {"\bblaug{}"}

MACRO {sep} {"\bblsep{}"}

MACRO {oct} {"\bbloct{}"}

MACRO {nov} {"\bblnov{}"}

MACRO {dec} {"\bbldec{}"}


FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}

FUNCTION {bibinfo.warn}
{ swap$
  duplicate$ missing$
    {
      swap$ "missing " swap$ * " in " * cite$ * warning$ pop$
      ""
    }
    { duplicate$ empty$
        {
          swap$ "empty " swap$ * " in " * cite$ * warning$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}



STRINGS  { bibinfo}
INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 'bibinfo :=
  duplicate$ empty$ 'skip$ {
  's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}" format.name$ bib.name.font
      s nameptr
      "{ff}{, jj}"
      format.name$ duplicate$ empty$ 'skip$
        { bib.fname.font ", " swap$ * }
      if$
      *
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {
          namesleft #1 >
            { "\nameseparator{} " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {
                  " " * bbl.etal cite.etal.font *
                }
                {
                  bbl.and bib.and.font
                  space.word * t *
                }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  } if$
}

FUNCTION {format.names.ed}
{
  'bibinfo :=
  duplicate$ empty$ 'skip$ {
  's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{ff~}{vv~}{ll}{, jj}"
      format.name$
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        {
          namesleft #1 >
            { "\nameseparator{} " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {

                  " " * bbl.etal cite.etal.font *
                }
                {
                  bbl.and cite.and.font
                  space.word * t *
                }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  } if$
}

FUNCTION {format.key}
{ empty$
    { key field.or.null }
    { "" }
  if$
}

FUNCTION {format.authors}
{ author "author" format.names}

FUNCTION {get.bbl.editor}
{ editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }

FUNCTION {format.editors}
{ editor "editor" format.names duplicate$ empty$ 'skip$
    {
      " " *
      get.bbl.editor
      capitalize
   "(" swap$ * ")" *
      *
    }
  if$
}

FUNCTION {format.isbn}
{ isbn "isbn" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      new.block
      "ISBN " swap$ * 
    }
  if$
}

FUNCTION {format.issn}
{ issn "issn" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      new.block
      "ISSN " swap$ *
    }
  if$
}


FUNCTION {format.url}
{ url empty$
    { "" }
    { new.block "\preurl{} \url{" url * "}" * }
  if$
}

FUNCTION {format.doi}
{ doi "doi" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      new.block
      "\doi{" swap$ * "}" *
    }
  if$
}

FUNCTION {format.mrnumber}
{ mrnumber "mrnumber" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      new.block
      "\MR{" swap$ * "}" *
    }
  if$
}


FUNCTION {select.hyphenation}
{ duplicate$ empty$
    'pop$
    { hyphenation empty$
        'skip$
        { "{\selectlanguage{" hyphenation * "}" * swap$ * "}" * }
      if$
    }
    if$
}

FUNCTION {format.note}
{
 note empty$
    { "" }
    { note #1 #1 substring$
      duplicate$ "{" =
        'skip$
        { output.state mid.sentence =
          { "l" }
          { "u" }
        if$
        change.case$
        }
      if$
      note #2 global.max$ substring$ * "note" bibinfo.check
    }
  if$
}

FUNCTION {format.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      "\bibtitle{\enquote{" swap$ *
      "}}" *
      select.hyphenation
    }
  if$
}


FUNCTION {format.translator}
{ translator
  "translator" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      "\bibtranslator{\bibtranslatorname " swap$ *
      "}" *
      select.hyphenation
    }
  if$
}


FUNCTION {format.small.title}
{ smalltitle
  "smalltitle" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      "{\bibsmalltitle{\emph{" swap$ *
      "}}}" *
      select.hyphenation
    }
  if$
}

FUNCTION {format.small.title.book}
{ smalltitle
  "smalltitle" bibinfo.check
  duplicate$ empty$ 'skip$
    {
      "{\bibsmalltitle{\emph{" swap$ *
      "}}} " *
      select.hyphenation
    }
  if$
}

FUNCTION {end.quote.btitle}
{ booktitle empty$
    'skip$
    { before.all 'output.state := }
  if$
}

FUNCTION {format.full.names}
{'s :=
 "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv~}{ll}" format.name$
      cite.name.font
      't :=
      nameptr #1 >
        {
          namesleft #1 >
            { ", " * t * }
            {
              s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                {
                  " " * bbl.etal cite.etal.font *
                }
                {
                  bbl.and cite.and.font
                  space.word * t *
                }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {author.editor.key.full}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.full.names }
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {author.key.full}
{ author empty$
    { key empty$
         { cite$ #1 #3 substring$ }
          'key
      if$
    }
    { author format.full.names }
  if$
}

FUNCTION {editor.key.full}
{ editor empty$
    { key empty$
         { cite$ #1 #3 substring$ }
          'key
      if$
    }
    { editor format.full.names }
  if$
}

FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.full
    { type$ "proceedings" =
        'editor.key.full
        'author.key.full
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[{" write$
  label write$
  ")"  make.full.names duplicate$ short.list =
     { pop$ }
     { * }
   if$
  format.small.title *
  "}]{" * write$
  cite$ write$
  "}" write$
  newline$      
  ""
  before.all 'output.state :=
}

FUNCTION {n.dashify}
{
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}

FUNCTION {word.in}
{ bbl.in capitalize
  ":" *
  bib.in.font
  " " * }

FUNCTION {format.date.begin}
{ year "year" bibinfo.check  
   duplicate$ empty$
   {"empty year in " cite$ *  warning$
    extra.label *
    before.all 'output.state :=
    "\datebegin " swap$ * "" * 
     }
   {extra.label *
    before.all 'output.state :=
    "\datebegin " swap$ * "." * }
   if$ 
}

FUNCTION {format.date.end}
{ year "year" bibinfo.check  
   duplicate$ empty$
   'skip$
   {extra.label *
    before.all 'output.state :=
    "\dateend{" swap$ * "}" *}
   if$ 
}

FUNCTION {format.btitle}
{ title "title" bibinfo.check
  duplicate$ empty$ 'skip$
    { like.book.title
      select.hyphenation
    }
  if$
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { bbl.volume volume tie.or.space.prefix
      "volume" bibinfo.check * *
      series "series" bibinfo.check
      duplicate$ empty$ 'pop$
        { swap$ bbl.of space.word * swap$
          emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { series empty$
            { number "number" bibinfo.check }
        { output.state mid.sentence =
            { bbl.number }
            { bbl.number capitalize }
          if$
          number tie.or.space.prefix "number" bibinfo.check * *
          bbl.in space.word *
          series "series" bibinfo.check *
        }
      if$
    }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$
    {
      output.state mid.sentence =
        { "l" }
        { "t" }
      if$ change.case$
      "edition" bibinfo.check
      bbl.edition *
    }
  if$
}
INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$
    { duplicate$ multi.page.check
        {
          bbl.pages swap$
          n.dashify
        }
        {
          bbl.page swap$
        }
      if$
      tie.or.space.prefix
      "pages" bibinfo.check
      * *
    }
  if$
}

FUNCTION {format.journal.pages}
{ pages duplicate$ empty$ 'pop$
    { swap$ duplicate$ empty$
        { pop$ pop$ format.pages }
        {
          ", " *
          swap$
          n.dashify
          pages multi.page.check
            'bbl.pages
            'bbl.page
          if$
          swap$ tie.or.space.prefix
          "pages" bibinfo.check
          * *
          *
        }
      if$
    }
  if$
}

FUNCTION {format.journal.eid}
{ eid "eid" bibinfo.check
  duplicate$ empty$ 'pop$
    { swap$ duplicate$ empty$ 'skip$
      {
          ", " *
      }
      if$
      swap$ *
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  duplicate$ empty$ 'skip$
    {
      "volume" bibinfo.check
    }
  if$
  number "number" bibinfo.check duplicate$ empty$ 'skip$
    {
      swap$ duplicate$ empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
      swap$
      "(" swap$ * ")" *
    }
  if$ *
  bib.vol.font
  eid empty$
    { format.journal.pages }
    { format.journal.eid }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { bbl.chapter }
        { type "l" change.case$
          "type" bibinfo.check
        }
      if$
      chapter tie.or.space.prefix
      "chapter" bibinfo.check
      * *
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {bt.enquote}
{ duplicate$ empty$ 'skip$
  { "\enquote{" swap$ *
    "}, " *
  }
  if$
}

FUNCTION {in.booktitle.font}
{ duplicate$ empty$ 'skip$
  { "\inbooktitlefont{" swap$ *
    "}, " *
  }
  if$
}

FUNCTION {format.booktitle}
{
  booktitle "booktitle" bibinfo.check
  in.booktitle.font
}

FUNCTION {format.in.ed.booktitle}
{ format.booktitle duplicate$ empty$ 'skip$
    {
      editor "editor" format.names.ed duplicate$ empty$ 'pop$
        {
          " " *
          get.bbl.editor
          capitalize
          "(" swap$ * "), " *
          * swap$
          * }
      if$
      word.in swap$ *
    }
  if$
}

FUNCTION {format.thesis.type}
{ type duplicate$ empty$
    'pop$
    { swap$ pop$
      "t" change.case$ "type" bibinfo.check
    }
  if$
}

FUNCTION {format.tr.number}
{ number "number" bibinfo.check
  type duplicate$ empty$
    { pop$ bbl.techrep }
    'skip$
  if$
  "type" bibinfo.check
  swap$ duplicate$ empty$
    { pop$ "t" change.case$ }
    { tie.or.space.prefix * * }
  if$
}

FUNCTION {format.article.crossref}
{
  word.in
  " \cite{" * crossref * "}" *
}

FUNCTION {format.book.crossref}
{ volume duplicate$ empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      pop$ word.in
    }
    { bbl.volume
      capitalize
      swap$ tie.or.space.prefix "volume" bibinfo.check * * bbl.of space.word *
    }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{
  word.in
  " \cite{" * crossref * "}" *
}

FUNCTION {format.org.or.pub}
{ 't :=
  ""
  address empty$ t empty$ and
    'skip$
    {
      t empty$
        { address "address" bibinfo.check *
        }
        { t *
          address empty$
            'skip$
            { ", " * address "address" bibinfo.check * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.publisher.address}
{ publisher "publisher" bibinfo.warn format.org.or.pub
}

FUNCTION {format.organization.address}
{ organization "organization" bibinfo.check format.org.or.pub
}

STRINGS {oldname}


FUNCTION {name.or.dash}
{ 's :=
   oldname empty$
     { s 'oldname := s }
     { s oldname =
         { " \namereplace{" write$  s 'oldname := s "}" *}
         { s 'oldname := s }
       if$
     }
   if$
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.checkb
  new.block
  format.title "title" output.check
  new.block
  format.translator "translator" output.checkc
  new.block
  crossref missing$
    {
      journal
      "journal" bibinfo.check
      emphasize
      "journal" output.check
      format.date.end "year" output.check
      format.vol.num.pages output
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  format.issn output
  format.doi output
  format.mrnumber output
  format.url output
  new.block
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
      name.or.dash
    }
    { format.authors output.nonnull
      name.or.dash
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  names.end
  year empty$
     {format.date.begin "year" output.check
     new.block}
     {format.date.begin "year" output.check
      new.block}
      if$
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      format.translator "translator" output.checkc
      new.sentence
      format.publisher.address output
    }
    {
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date.end "year" output.check
  format.isbn output
  format.doi output
  format.mrnumber output
  format.url output
  new.block
  format.note output
  fin.entry
 }

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title "title" output.check
  new.block
  howpublished "howpublished" bibinfo.check output
  address "address" bibinfo.check output
  format.date.end "year" output.check
  format.isbn output
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check
      editor format.key output
      name.or.dash
    }
    { format.authors output.nonnull
      name.or.dash
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  names.end
  format.date.begin "year" output.check
  new.block
  format.btitle "title" output.check
%  new.block
%  format.translator "translator" output.checkc
%  new.block  
  crossref missing$
    {
      format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      format.publisher.address output
    }
    {
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  crossref missing$
    { format.isbn output }
    'skip$
  if$
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      end.quote.btitle
      null.block
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      format.publisher.address output
      format.edition output
      format.date.end "year" output.check
      format.isbn output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
} 

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      end.quote.btitle
      format.bvolume output
      format.number.series output
      format.pages output
      new.sentence
      publisher empty$
        { format.organization.address output }
        { organization "organization" bibinfo.check output
          format.publisher.address output
        }
      if$
      format.isbn output
      format.issn output
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  format.authors output
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.btitle "title" output.check
  organization address new.block.checkb
  organization "organization" bibinfo.check output
  address "address" bibinfo.check output
  format.edition output
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.btitle
  "title" output.check
  new.block
  bbl.mthesis format.thesis.type output.nonnull
  school "school" bibinfo.warn output
  address "address" bibinfo.check output
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title output
  new.block
  howpublished "howpublished" bibinfo.check output
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.btitle
  "title" output.check
  new.block
  bbl.phdthesis format.thesis.type output.nonnull
  school "school" bibinfo.warn output
  address "address" bibinfo.check output
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  format.editors output
  editor format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  new.sentence
  publisher empty$
    { format.organization.address output }
    { organization "organization" bibinfo.check output
      format.publisher.address output
    }
  if$
  format.date.end "year" output.check
  format.isbn output
  format.issn output
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number emphasize output.nonnull
  institution "institution" bibinfo.warn output
  address "address" bibinfo.check output
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  author format.key output
  name.or.dash
  names.end
  format.date.begin "year" output.check
  new.block
  format.title "title" output.check
  format.date.end "year" output.check
  format.doi output
  format.url output
  new.block
  format.note "note" output.check
  fin.entry
}

FUNCTION {default.type} { misc }
READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}
INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.lab.names}
{ 's :=
  "" 't :=
  s #1 "{vv~}{ll}" format.name$
  cite.name.font
  s num.names$ duplicate$
  #2 >
    { pop$
      " " * bbl.etal cite.etal.font *
    }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            {
              " " * bbl.etal cite.etal.font *
            }
            { bbl.and cite.and.font space.word * s #2 "{vv~}{ll}" format.name$
              cite.name.font
              * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {author.key.label}
{ author empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {author.editor.key.label}
{ author empty$
    { editor empty$
        { key empty$
            { cite$ #1 #3 substring$ }
            'key
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
}

FUNCTION {editor.key.label}
{ editor empty$
    { key empty$
        { cite$ #1 #3 substring$ }
        'key
      if$
    }
    { editor format.lab.names }
  if$
}

FUNCTION {calc.short.authors}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.key.label
    { type$ "proceedings" =
        'editor.key.label
        'author.key.label
      if$
    }
  if$
  'short.list :=
}

FUNCTION {calc.label}
{ calc.short.authors
  short.list
  "("
  *
  year duplicate$ empty$
     { pop$ "" }
     'skip$
  if$
  *
  'label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}"
      format.name$ 't :=
      nameptr #1 >
        {
          "   "  *
          namesleft #1 = t "others" = and
            { "zzzzz" * }
            { t sortify * }
          if$
        }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.sort}
{ editor empty$
    { key empty$
        { "to sort, need editor or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ calc.label
  label sortify
  "    "
  *
  type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.sort
        'author.sort
      if$
    }
  if$
  #1 entry.max$ substring$
  'sort.label :=
  sort.label
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}
SORT
STRINGS { last.label next.extra }
INTEGERS { last.extra.num number.label }

FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}
EXECUTE {initialize.extra.label.stuff}
ITERATE {forward.pass}
REVERSE {reverse.pass}
FUNCTION {bib.sort.order}
{ sort.label
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}
ITERATE {bib.sort.order}
SORT

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" number.label int.to.str$ * "}" *
  write$ newline$
  "%Comandos de formato, por si no est'an definidos."
write$ newline$
"\ProvideTextCommand{\guillemotleft}{OT1}{\leavevmode\raise .27ex\hbox{$\scriptscriptstyle\ll$}} \ProvideTextCommand{\guillemotright}{OT1}{\leavevmode\raise .27ex\hbox{$\scriptscriptstyle\gg$}}"
write$ newline$
"\providecommand{\enquote}[1]{\guillemotleft#1\guillemotright} \providecommand{\natexlab}[1]{#1} \providecommand{\bibnamefont}[1]{\textsc{#1}} \providecommand{\bibfnamefont}[1]{\textsc{#1}} \providecommand{\bibfnamefontand}[1]{#1} \providecommand{\citenamefont}[1]{#1} \providecommand{\bibnamefont}[1]{\textsc{#1}} \providecommand{\bbletalfont}[1]{\emph{#1}}  \providecommand{\citeandfont}[1]{#1} \providecommand{\citetalfont}[1]{#1} \providecommand{\bibyearfont}[1]{#1} \providecommand{\isbn}[1]{ISBN #1} \providecommand{\url}[1]{\texttt{#1}} \providecommand{\urlprefix}{} \providecommand{\nameseparator}{;} \providecommand{\namereplace}[1]{{---{}---} \ifx\datebegin\relax \else \def\datebegin #1.{\relax}\fi} \providecommand{\dateend}[1]{, #1} \providecommand{\bibtitle}[1]{#1}\providecommand{\bibtranslator}[1]{#1} \providecommand{\bibtranslatorname}{Traducido por } \providecommand{\selectlanguage}[1]{\relax} \providecommand{\finalpoint}{.} \providecommand{\namesend}{:} \providecommand{\Capitalize}[1]{\uppercase{#1}} \providecommand{\capitalize}[1]{\expandafter\Capitalize#1} \providecommand{\bibinfont}[1]{\textbf{#1}} \providecommand{\inbooktitlefont}[1]{\emph{#1}} \providecommand{\bibvolfont}[1]{\textbf{#1}} \providecommand{\bibandfont}[1]{#1}  \providecommand{\bibcommentname}{\textsc{Obs:}} \providecommand{\bibcomment}[2]{\begin{quotation} \noindent\textsc{\bibcommentname}\ #2\end{quotation}} \providecommand{\bibabstract}[2]{\begin{quotation} \noindent\textsc{\Abstractname:}\ #2\end{quotation}}"
write$ newline$
"\providecommand{\bblin}{En} \providecommand{\bbland}{y} \providecommand{\bbletal}{et al.} \providecommand{\bbled}{ed.} \providecommand{\bbleds}{Eds.} \providecommand{\bbvolume}{Vol.}  \providecommand{\bblof}{de} \providecommand{\bbledition}{ª~edición} \providecommand{\bblp}{p.}  \providecommand{\bblpp}{pp.} \providecommand{\bbltechreport}{Informe técnico} \providecommand{\bblmthesis}{Tesina} \providecommand{\bblphdthesis}{Tesis doctoral} \providecommand{\bblchapter}{cap\'\i{}tulo} \providecommand{\bblnumber}{número} \providecommand{\bblvolume}{volumen} \providecommand{\MR}[1]{\relax\ifhmode\unskip\space\fi MR #1} \expandafter\ifx\csname urlstyle\endcsname\relax \providecommand{\doi}[1]{doi: #1}\else  \providecommand{\doi}{doi: \begingroup \urlstyle{rm}\Url}\fi"
  write$ newline$
  "%Para resultados estilo plain descomente la l'inea siguiente"
  write$ newline$
  "%\let\oldbibitem=\bibitem \def\bibitem[#1]#2{\oldbibitem{#2}}"
  write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
