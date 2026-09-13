#import "../components/lab-section.typ": lab-section

#lab-section(title: "REFERENCIAS")[
  #show heading: set text(weight: "bold")
  #bibliography("../bibliography.bib", style: "ieee")
  
  #v(0.3em)
  #pad(1.1em)[
    Android Developers. (2026). _Jetpack Compose basics_ [Codelab]. https://developer.android.com/codelabs/jetpack-compose-basics
    #v(0.2em)
    Android Developers. (2026). _Thinking in Compose_. https://developer.android.com/develop/ui/compose/mental-model
    #v(0.2em)
    Android Developers. (2026). _Data and file storage overview_. https://developer.android.com/training/data-storage
  ]
]
