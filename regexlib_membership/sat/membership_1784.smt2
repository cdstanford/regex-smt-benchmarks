;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])(\s{0,1})(AM|PM|am|pm|aM|Am|pM|Pm{2,2})$)|(^([0-9]|[1][0-9]|[2][0-3])(\s{0,1})(AM|PM|am|pm|aM|Am|pM|Pm{2,2})$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "21:52\xDPM"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "1" (seq.++ ":" (seq.++ "5" (seq.++ "2" (seq.++ "\x0d" (seq.++ "P" (seq.++ "M" "")))))))))
;witness2: "20:55AM"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "0" (seq.++ ":" (seq.++ "5" (seq.++ "5" (seq.++ "A" (seq.++ "M" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "M" ""))) (re.++ (re.range "P" "P") ((_ re.loop 2 2) (re.range "m" "m")))))))))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "M" ""))) (re.++ (re.range "P" "P") ((_ re.loop 2 2) (re.range "m" "m")))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
