;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((0?[1-9]|1[012])/(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])/(29|30)|(0?[13578]|1[02])/31)/(19|[2-9]\d)\d{2}|0?2/29/((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00))))[\s]((([0]?[1-9]|1[0-2])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2/29/2000\u00A005:38"
(define-fun Witness1 () String (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ "0" (str.++ "\u{a0}" (str.++ "0" (str.++ "5" (str.++ ":" (str.++ "3" (str.++ "8" ""))))))))))))))))
;witness2: "10/29/4952 04:58:32"
(define-fun Witness2 () String (str.++ "1" (str.++ "0" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "4" (str.++ "9" (str.++ "5" (str.++ "2" (str.++ " " (str.++ "0" (str.++ "4" (str.++ ":" (str.++ "5" (str.++ "8" (str.++ ":" (str.++ "3" (str.++ "2" ""))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/") (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "8"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1") (re.range "3" "9"))) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/") (re.union (str.to_re (str.++ "2" (str.++ "9" ""))) (str.to_re (str.++ "3" (str.++ "0" "")))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2")))) (str.to_re (str.++ "/" (str.++ "3" (str.++ "1" "")))))))(re.++ (re.range "/" "/")(re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (re.++ (re.range "2" "9") (re.range "0" "9"))) ((_ re.loop 2 2) (re.range "0" "9"))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (str.to_re (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "/" "")))))) (re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" ""))) (re.++ (re.range "2" "9") (re.range "0" "9"))) (re.union (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))(re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))) (re.++ (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "0" ""))))))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.range " " " ")) (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" ""))) (str.to_re (str.++ "P" (str.++ "m" "")))))))))))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (re.opt (re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
