;;; file-fetcher.lisp

;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(defpackage #:ql-file-fetcher
  (:nicknames #:file-fetcher #:ff)
  (:use :cl)
  (:export
   #:file-fetch))

(in-package #:ql-file-fetcher)

(defun file-uri-p (uri)
  (string= (quri:uri-scheme uri) "file"))

(defun file-fetch (url file)
  "Copy contents from URL to FILE"
  (let ((uri (quri:make-uri :defaults url)))
    (if (file-uri-p uri)
        (if (probe-file (quri:uri-path uri))
            (uiop:copy-file (quri:uri-path uri) file)
            (error "File does not exist: ~A" (quri:uri-path uri)))
        (error "~A not a file URL" url))))

#+quicklisp
(push (cons "file" 'file-fetch) ql-http:*fetch-scheme-functions*)
