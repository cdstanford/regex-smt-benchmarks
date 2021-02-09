;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<prov>10)(?<tipo>(AV))?-(?<tomo>\d{1,4})-(?<folio>\d{1,5})|^(?<prov>[1-9])(?<tipo>(AV))?-(?<tomo>\d{1,4})-(?<folio>\d{1,5})|^(?<tipo>(E|N|PE))-(?<tomo>\d{1,4})-(?<folio>\d{1,5})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "E-9289-8488"
(define-fun Witness1 () String (seq.++ "E" (seq.++ "-" (seq.++ "9" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "8" (seq.++ "8" ""))))))))))))
;witness2: "E-6-9998"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "-" (seq.++ "6" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "1" (seq.++ "0" "")))(re.++ (re.opt (str.to_re (seq.++ "A" (seq.++ "V" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9"))))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ (re.opt (str.to_re (seq.++ "A" (seq.++ "V" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9")))))))) (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "E" "E") (re.range "N" "N")) (str.to_re (seq.++ "P" (seq.++ "E" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
