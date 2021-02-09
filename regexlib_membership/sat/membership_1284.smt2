;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<CountryPrefix>DK-)?(?<ZipCode>[0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "DK-6896"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "K" (seq.++ "-" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "6" ""))))))))
;witness2: "3389"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "3" (seq.++ "8" (seq.++ "9" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (seq.++ "D" (seq.++ "K" (seq.++ "-" "")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
