;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^011-(?<IntlCountryCode>[1-9][0-9]{1,5})-(?<IntlAreaCode>[0-9]+)-(?<IntlPhoneNumber>[0]?\d[0-9]+)(?:[^\d\-]+(?<IntlExtension>\d{1,4}))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "011-968-459-0238"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "-" (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "2" (seq.++ "3" (seq.++ "8" "")))))))))))))))))
;witness2: "011-97889-9-040969"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "4" (seq.++ "0" (seq.++ "9" (seq.++ "6" (seq.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "1" (seq.++ "1" (seq.++ "-" "")))))(re.++ (re.++ (re.range "1" "9") ((_ re.loop 1 5) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "0" "9") (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "\x00" ",")(re.union (re.range "." "/") (re.range ":" "\xff")))) ((_ re.loop 1 4) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
