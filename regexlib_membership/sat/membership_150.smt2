;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = -[0-9]*[x][0-9]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-28xh-\u0098\u00C8"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "x" (seq.++ "h" (seq.++ "-" (seq.++ "\x98" (seq.++ "\xc8" "")))))))))
;witness2: "E\x3-09x"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "\x03" (seq.++ "-" (seq.++ "0" (seq.++ "9" (seq.++ "x" "")))))))

(assert (= regexA (re.++ (re.range "-" "-")(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "x" "x") (re.* (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
