;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \.com/(\d+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B3.com/8"
(define-fun Witness1 () String (seq.++ "\xb3" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "8" ""))))))))
;witness2: "\xC\u0093v.com/18"
(define-fun Witness2 () String (seq.++ "\x0c" (seq.++ "\x93" (seq.++ "v" (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" (seq.++ "1" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "." (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "/" ""))))))(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
