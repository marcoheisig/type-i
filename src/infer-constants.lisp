(in-package :type-i)

(in-optimizer :trivial)
;;; null

(defvar +null-tests+
    `((typep ? 'null)
      (typep ? '(eql nil))
      (null ?)
      (eql ? nil)
      (eql nil ?)
      (eq ? nil)
      (eq nil ?)
      (equal ? nil)
      (equal nil ?)
      (equalp ? nil)
      (equalp nil ?)))

(define-inference-rule null-tests (test)
  (when (member test +null-tests+ :test #'equal)
    +null-tests+))

(define-inference-rule true-tests (test)
  (when (eq test t)
    '((typep ? 't)
      (typep ? '(eql t))))) ;; should be quoted, see definition of test-type

(define-inference-rule eql-tests (test)
  (match test
    ((or (list 'eql '? what)
         (list 'eql what '?)
         (list 'eq '? what)
         (list 'eq what '?))
     `((typep ? '(eql ,what))))))


(define-inference-rule equal-equalp-tests (test)
  (match test
    ((or (list 'equal '? what)
         (list 'equal what '?)
         (list 'equalp '? what)
         (list 'equalp what '?))
     `((typep ? ',(type-of what))))))
