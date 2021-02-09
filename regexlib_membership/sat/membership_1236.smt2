;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<national>\+?(?:86)?)(?<separator>\s?-?)(?<phone>(?<vender>13[0-4])(?<area>\d{4})(?<id>\d{4}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "+86\u0085-13495888595"
(define-fun Witness1 () String (seq.++ "+" (seq.++ "8" (seq.++ "6" (seq.++ "\x85" (seq.++ "-" (seq.++ "1" (seq.++ "3" (seq.++ "4" (seq.++ "9" (seq.++ "5" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "5" "")))))))))))))))))
;witness2: "+86-13408968932"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "8" (seq.++ "6" (seq.++ "-" (seq.++ "1" (seq.++ "3" (seq.++ "4" (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "3" (seq.++ "2" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "+" "+")) (re.opt (str.to_re (seq.++ "8" (seq.++ "6" "")))))(re.++ (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.range "-" "-")))(re.++ (re.++ (re.++ (str.to_re (seq.++ "1" (seq.++ "3" ""))) (re.range "0" "4"))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 4 4) (re.range "0" "9")))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
