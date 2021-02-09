;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^0?[1-9]|^1[0-2])\/(0?[1-9]|[1-2][0-9]|3[0-1])\/(19|20)?[0-9][0-9](\s(((0?[0-9]|1[0-9]|2[0-3]):[0-5][0-9](:[0-5][0-9])?)|((0?[0-9]|1[0-2]):[0-5][0-9](:[0-5][0-9])?\s(AM|PM))))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "6/20/2091"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "9" (seq.++ "1" ""))))))))))
;witness2: "12/30/2066\u00A018:32"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "3" (seq.++ "0" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "6" (seq.++ "6" (seq.++ "\xa0" (seq.++ "1" (seq.++ "8" (seq.++ ":" (seq.++ "3" (seq.++ "2" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))) (re.++ (str.to_re "")(re.++ (re.range "1" "1") (re.range "0" "2"))))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ (re.opt (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" "")))))(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.union (str.to_re (seq.++ "A" (seq.++ "M" ""))) (str.to_re (seq.++ "P" (seq.++ "M" ""))))))))))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
