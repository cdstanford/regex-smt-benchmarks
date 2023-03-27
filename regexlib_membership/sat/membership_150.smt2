;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = -[0-9]*[x][0-9]*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "-28xh-\u0098\u00C8"
(define-fun Witness1 () String (str.++ "-" (str.++ "2" (str.++ "8" (str.++ "x" (str.++ "h" (str.++ "-" (str.++ "\u{98}" (str.++ "\u{c8}" "")))))))))
;witness2: "E\x3-09x"
(define-fun Witness2 () String (str.++ "E" (str.++ "\u{03}" (str.++ "-" (str.++ "0" (str.++ "9" (str.++ "x" "")))))))

(assert (= regexA (re.++ (re.range "-" "-")(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "x" "x") (re.* (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
