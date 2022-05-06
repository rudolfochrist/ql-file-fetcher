;;; ql-file-fetcher.asd

;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(defsystem "ql-file-fetcher"
  :author "Sebastian Christ <rudolfo.christ@pm.me>"
  :maintainer "Sebastian Christ <rudolfo.christ@pm.me>"
  :mailto "rudolfo.christ@pm.me"
  :license "MPL-2.0"
  :homepage "https://github.com/rudolfochrist/ql-file-fetcher"
  :bug-tracker "https://github.com/rudolfochrist/ql-file-fetcher/issues"
  :source-control (:git "https://github.com/rudolfochrist/ql-file-fetcher.git")
  :version (:read-file-line "version")
  :depends-on ((:require "uiop")
               "quri")
  :components ((:file "file-fetcher"))
  :description "Quicklisp fetcher for file:// URLs"
  :long-description
  #.(uiop:read-file-string
     (uiop:subpathname *load-pathname* "README.txt"))
  :in-order-to ((test-op (test-op "ql-file-fetcher/test"))))


(defsystem "ql-file-fetcher/test"
  :depends-on ((:require "uiop")
               "fiveam"
               "ql-file-fetcher")
  :pathname "t/"
  :components ((:file "tests"))
  :perform (test-op (op c)
                    (when (and (not (uiop:symbol-call :fiveam :run! :ql-file-fetcher))
                               (uiop:getenv "NON_INTERACTIVE_TESTS"))
                      (uiop:quit 1))))


