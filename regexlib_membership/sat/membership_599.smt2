;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d+(-\d+)*)+(,\d+(-\d+)*)*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "953,88"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "5" (seq.++ "3" (seq.++ "," (seq.++ "8" (seq.++ "8" "")))))))
;witness2: "\x8193989,5-778-9293\u00A2\u00FB\u00B3"
(define-fun Witness2 () String (seq.++ "\x08" (seq.++ "1" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "," (seq.++ "5" (seq.++ "-" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "3" (seq.++ "\xa2" (seq.++ "\xfb" (seq.++ "\xb3" ""))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.range "-" "-") (re.+ (re.range "0" "9")))))) (re.* (re.++ (re.range "," ",")(re.++ (re.+ (re.range "0" "9")) (re.* (re.++ (re.range "-" "-") (re.+ (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
