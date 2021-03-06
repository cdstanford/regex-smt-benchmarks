;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \A((?:[01]{0,1}\d)|(?:[2][0123])):([012345]\d):([012345]\d)(.\d{1,3})?([Z]|(?:[+-]?(?:[01]{0,1}\d)|(?:[2][0123])):([012345]\d))\Z
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0:49:01Z"
(define-fun Witness1 () String (seq.++ "0" (seq.++ ":" (seq.++ "4" (seq.++ "9" (seq.++ ":" (seq.++ "0" (seq.++ "1" (seq.++ "Z" "")))))))))
;witness2: "11:33:41-6:50"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "1" (seq.++ ":" (seq.++ "3" (seq.++ "3" (seq.++ ":" (seq.++ "4" (seq.++ "1" (seq.++ "-" (seq.++ "6" (seq.++ ":" (seq.++ "5" (seq.++ "0" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) ((_ re.loop 1 3) (re.range "0" "9"))))(re.++ (re.union (re.range "Z" "Z") (re.++ (re.union (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-")))(re.++ (re.opt (re.range "0" "1")) (re.range "0" "9"))) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":") (re.++ (re.range "0" "5") (re.range "0" "9"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
