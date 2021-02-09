;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))(-?\s?\d{4}){3}|(3[4,7])\d{2}-?\s?\d{6}-?\s?\d{5}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00CD3758-\u008549314900814"
(define-fun Witness1 () String (seq.++ "\xcd" (seq.++ "3" (seq.++ "7" (seq.++ "5" (seq.++ "8" (seq.++ "-" (seq.++ "\x85" (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ "1" (seq.++ "4" (seq.++ "9" (seq.++ "0" (seq.++ "0" (seq.++ "8" (seq.++ "1" (seq.++ "4" "")))))))))))))))))))
;witness2: "3,88-989980-88188"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "," (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "8" (seq.++ "8" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "6" (seq.++ "7" ""))) ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "4" "4") ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "5" "5")(re.++ (re.range "1" "5") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re (seq.++ "6" (seq.++ "0" (seq.++ "1" (seq.++ "1" "")))))))) ((_ re.loop 3 3) (re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))) (re.++ (re.++ (re.range "3" "3") (re.union (re.range "," ",")(re.union (re.range "4" "4") (re.range "7" "7"))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
