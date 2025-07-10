;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \.com/(\d+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00B3.com/8"
(define-fun Witness1 () String (str.++ "\u{b3}" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "8" ""))))))))
;witness2: "\xC\u0093v.com/18"
(define-fun Witness2 () String (str.++ "\u{0c}" (str.++ "\u{93}" (str.++ "v" (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" (str.++ "1" (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "." (str.++ "c" (str.++ "o" (str.++ "m" (str.++ "/" ""))))))(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
