require'agrp'.set{
  my_ftdetect = {
    ['BufNewFile,BufRead'] = {
      {'*.gs,.amethyst ', [[set filetype=javascript]]},
      {'*.jbuilder ', [[set filetype=ruby]]},
      {'*/nginx* ', [[set filetype=nginx]]},
      {'*.m ', [[setf objc]]},
      {'*.h ', [[setf objc]]},
      {'*pentadactylrc*,*.penta ', [[set filetype=pentadactyl]]},
      {'*.t', [[call delphinus#perl#test_filetype()]]},
      {'*.xt', [[call delphinus#perl#test_filetype()]]},
      {'*', [[if getline(1) =~ '^.*startuml.*$'|  ', [[setfiletype plantuml | endif]]},
      {'*.psgi ', [[set filetype=perl]]},
      {'*.pu,*.uml,*.plantuml ', [[setfiletype plantuml]]},
      {'*.conf', require'ftdetect'.tmux},
      {'*.tt2 ', [[setf tt2html]]},
      {'*.tt ', [[setf tt2html]]},
      {'.zpreztorc ', [[setf zsh]]},
      {'*.plist,*.ttx ', [[setf xml]]},
      {'*.applescript', [[setf applescript]]},
      {'*.cc', [[setf cpp]]},
      {'*.cpp', [[setf cpp]]},
      {'*.cxx,*.c++,*.hh,*.hxx,*.hpp,*.ipp,*.moc,*.tcc,*.inl', [[setf cpp]]},
      {'*.h', [[call dist#ft#FTheader()]]},
    },
  },
}
