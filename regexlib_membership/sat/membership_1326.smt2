;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA =   [-]\d{0,2}(?:\.\d{0,2})?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "P}  -79."
(define-fun Witness1 () String (seq.++ "P" (seq.++ "}" (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ "7" (seq.++ "9" (seq.++ "." "")))))))))
;witness2: "  -\u008C\u0082\u00B1"
(define-fun Witness2 () String (seq.++ " " (seq.++ " " (seq.++ "-" (seq.++ "\x8c" (seq.++ "\x82" (seq.++ "\xb1" "")))))))

(assert (= regexA (re.++ (str.to_re (seq.++ " " (seq.++ " " (seq.++ "-" ""))))(re.++ ((_ re.loop 0 2) (re.range "0" "9")) (re.opt (re.++ (re.range "." ".") ((_ re.loop 0 2) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
