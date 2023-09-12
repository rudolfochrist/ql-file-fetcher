;;; file-fetcher.lisp

;;; This Source Code Form is subject to the terms of the Mozilla Public
;;; License, v. 2.0. If a copy of the MPL was not distributed with this
;;; file, You can obtain one at http://mozilla.org/MPL/2.0/.

(defpackage #:ql-file-fetcher
  (:use :cl)
  (:export
   #:fetch-file))

(in-package #:ql-file-fetcher)

(defun file-uri-p (uri)
  (uiop:string-prefix-p "file://" uri))

(defun uri-path (uri)
  (subseq uri (length "file://")))

(defun fetch-file (uri file &rest rest)
  "Copy contents from URL to FILE"
  (declare (ignore rest))
  (if (file-uri-p uri)
      (if (probe-file (uri-path uri))
          (progn (uiop:copy-file (uri-path uri) file)
                 (values "" ; empty header
                         file))
          (error "File does not exist: ~A" (uri-path uri)))
      (error "~A not a file URL" uri)))

