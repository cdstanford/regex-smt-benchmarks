;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[a-zA-Z0-9]+://)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "P://"
(define-fun Witness1 () String (seq.++ "P" (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))
;witness2: "8://\u00F4\u00FC\u00A7\u00ED"
(define-fun Witness2 () String (seq.++ "8" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\xf4" (seq.++ "\xfc" (seq.++ "\xa7" (seq.++ "\xed" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
