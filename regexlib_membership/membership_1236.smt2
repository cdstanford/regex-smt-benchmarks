;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<national>\+?(?:86)?)(?<separator>\s?-?)(?<phone>(?<vender>13[0-4])(?<area>\d{4})(?<id>\d{4}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+86\u0085-13495888595"
(define-fun Witness1 () String (str.++ "+" (str.++ "8" (str.++ "6" (str.++ "\u{85}" (str.++ "-" (str.++ "1" (str.++ "3" (str.++ "4" (str.++ "9" (str.++ "5" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "5" "")))))))))))))))))
;witness2: "+86-13408968932"
(define-fun Witness2 () String (str.++ "+" (str.++ "8" (str.++ "6" (str.++ "-" (str.++ "1" (str.++ "3" (str.++ "4" (str.++ "0" (str.++ "8" (str.++ "9" (str.++ "6" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "2" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "+" "+")) (re.opt (str.to_re (str.++ "8" (str.++ "6" "")))))(re.++ (re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.opt (re.range "-" "-")))(re.++ (re.++ (re.++ (str.to_re (str.++ "1" (str.++ "3" ""))) (re.range "0" "4"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
