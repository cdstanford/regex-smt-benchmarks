;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d+(-\d+)*)+(,\d+(-\d+)*)*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "953,88"
(define-fun Witness1 () String (str.++ "9" (str.++ "5" (str.++ "3" (str.++ "," (str.++ "8" (str.++ "8" "")))))))
;witness2: "\x8193989,5-778-9293\u00A2\u00FB\u00B3"
(define-fun Witness2 () String (str.++ "\u{08}" (str.++ "1" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "," (str.++ "5" (str.++ "-" (str.++ "7" (str.++ "7" (str.++ "8" (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "\u{a2}" (str.++ "\u{fb}" (str.++ "\u{b3}" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.range "-" "-") (re.+ (re.range "0" "9")))))) (re.* (re.++ (re.range "," ",")(re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.range "-" "-") (re.+ (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
