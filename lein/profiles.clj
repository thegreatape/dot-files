{:user
 {:plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]]
  :dependencies [[slamhound "1.5.5"]
                 [spyscope "0.1.3"]
                 [redl "0.2.4"]]
  :injections [(require 'spyscope.core)
               (require '[redl complete core])]}}
