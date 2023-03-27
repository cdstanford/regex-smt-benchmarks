;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^011-(?<IntlCountryCode>[1-9][0-9]{1,5})-(?<IntlAreaCode>[0-9]+)-(?<IntlPhoneNumber>[0]?\d[0-9]+)(?:[^\d\-]+(?<IntlExtension>\d{1,4}))?$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "011-968-459-0238"
(define-fun Witness1 () String (str.++ "0" (str.++ "1" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "-" (str.++ "4" (str.++ "5" (str.++ "9" (str.++ "-" (str.++ "0" (str.++ "2" (str.++ "3" (str.++ "8" "")))))))))))))))))
;witness2: "011-97889-9-040969"
(define-fun Witness2 () String (str.++ "0" (str.++ "1" (str.++ "1" (str.++ "-" (str.++ "9" (str.++ "7" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "9" (str.++ "-" (str.++ "0" (str.++ "4" (str.++ "0" (str.++ "9" (str.++ "6" (str.++ "9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "1" (str.++ "1" (str.++ "-" "")))))(re.++ (re.++ (re.range "1" "9") ((_ re.loop 1 5) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "0" "9") (re.+ (re.range "0" "9"))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "\u{00}" ",")(re.union (re.range "." "/") (re.range ":" "\u{ff}")))) ((_ re.loop 1 4) (re.range "0" "9")))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
