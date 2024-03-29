;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])(\s{0,1})(AM|PM|am|pm|aM|Am|pM|Pm{2,2})$)|(^([0-9]|[1][0-9]|[2][0-3])(\s{0,1})(AM|PM|am|pm|aM|Am|pM|Pm{2,2})$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "21:52\xDPM"
(define-fun Witness1 () String (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "5" (str.++ "2" (str.++ "\u{0d}" (str.++ "P" (str.++ "M" "")))))))))
;witness2: "20:55AM"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "5" (str.++ "5" (str.++ "A" (str.++ "M" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" ""))) (re.++ (re.range "P" "P") ((_ re.loop 2 2) (re.range "m" "m")))))))))) (str.to_re ""))))))) (re.++ (str.to_re "")(re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" ""))) (re.++ (re.range "P" "P") ((_ re.loop 2 2) (re.range "m" "m")))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
