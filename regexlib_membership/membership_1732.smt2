;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \({1}[0-9]{3}\){1}\-{1}[0-9]{3}\-{1}[0-9]{4}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "(878)-558-9188\u00EA\u00D5"
(define-fun Witness1 () String (str.++ "(" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ ")" (str.++ "-" (str.++ "5" (str.++ "5" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "\u{ea}" (str.++ "\u{d5}" "")))))))))))))))))
;witness2: "m(282)-263-4312\x1D["
(define-fun Witness2 () String (str.++ "m" (str.++ "(" (str.++ "2" (str.++ "8" (str.++ "2" (str.++ ")" (str.++ "-" (str.++ "2" (str.++ "6" (str.++ "3" (str.++ "-" (str.++ "4" (str.++ "3" (str.++ "1" (str.++ "2" (str.++ "\u{1d}" (str.++ "[" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (str.to_re (str.++ ")" (str.++ "-" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
