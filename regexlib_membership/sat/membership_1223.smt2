;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (02\d\s?\d{4}\s?\d{4})|(01\d{2}\s?\d{3}\s?\d{4})|(01\d{3}\s?\d{5,6})|(01\d{4}\s?\d{4,5})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F6O\u00B901899859800"
(define-fun Witness1 () String (seq.++ "\xf6" (seq.++ "O" (seq.++ "\xb9" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "0" "")))))))))))))))
;witness2: "019839\u00A089872"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "\xa0" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "7" (seq.++ "2" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "2" "")))(re.++ (re.range "0" "9")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 5 6) (re.range "0" "9"))))) (re.++ (str.to_re (seq.++ "0" (seq.++ "1" "")))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 5) (re.range "0" "9"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
