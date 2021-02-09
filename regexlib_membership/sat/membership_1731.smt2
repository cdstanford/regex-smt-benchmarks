;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^abc]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "g\x6\u00F7"
(define-fun Witness1 () String (seq.++ "g" (seq.++ "\x06" (seq.++ "\xf7" ""))))
;witness2: "i\u0081"
(define-fun Witness2 () String (seq.++ "i" (seq.++ "\x81" "")))

(assert (= regexA (re.union (re.range "\x00" "`") (re.range "d" "\xff"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
