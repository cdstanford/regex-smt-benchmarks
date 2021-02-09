;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z]{3}\s?(\d{3}|\d{2}|d{1})\s?[A-Z])|([A-Z]\s?(\d{3}|\d{2}|\d{1})\s?[A-Z]{3})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "S 98\x9ZXG"
(define-fun Witness1 () String (seq.++ "S" (seq.++ " " (seq.++ "9" (seq.++ "8" (seq.++ "\x09" (seq.++ "Z" (seq.++ "X" (seq.++ "G" "")))))))))
;witness2: "yZ 2TAY"
(define-fun Witness2 () String (seq.++ "y" (seq.++ "Z" (seq.++ " " (seq.++ "2" (seq.++ "T" (seq.++ "A" (seq.++ "Y" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "d" "d")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.range "A" "Z")))))) (re.++ (re.++ (re.range "A" "Z")(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union ((_ re.loop 3 3) (re.range "0" "9"))(re.union ((_ re.loop 2 2) (re.range "0" "9")) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "A" "Z")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
