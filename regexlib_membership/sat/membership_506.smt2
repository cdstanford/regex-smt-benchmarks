;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((((((jan(uary)?)|(mar(ch)?)|(may)|(july?)|(aug(ust)?)|(oct(ober)?)|(dec(ember)?)) ((3[01])|29))|(((apr(il)?)|(june?)|(sep(tember)?)|(nov(ember)?)) ((30)|(29)))|(((jan(uary)?)|(feb(ruary)?|(mar(ch)?)|(apr(il)?)|(may)|(june?)|(july?)|(aug(ust)?)|(sep(tember)?)|(oct(ober)?)|(nov(ember)?)|(dec(ember)?))) (2[0-8]|(1\d)|(0?[1-9])))),? )|(((((1[02])|(0?[13578]))[\.\-/]((3[01])|29))|(((11)|(0?[469]))[\.\-/]((30)|(29)))|(((1[0-2])|(0?[1-9]))[\.\-/](2[0-8]|(1\d)|(0?[1-9]))))[\.\-/])|(((((3[01])|29)[ \-\./]((jan(uary)?)|(mar(ch)?)|(may)|(july?)|(aug(ust)?)|(oct(ober)?)|(dec(ember)?)))|(((30)|(29))[ \.\-/]((apr(il)?)|(june?)|(sep(tember)?)|(nov(ember)?)))|((2[0-8]|(1\d)|(0?[1-9]))[ \.\-/]((jan(uary)?)|(feb(ruary)?|(mar(ch)?)|(apr(il)?)|(may)|(june?)|(july?)|(aug(ust)?)|(sep(tember)?)|(oct(ober)?)|(nov(ember)?)|(dec(ember)?)))))[ \-\./])|((((3[01])|29)((jan)|(mar)|(may)|(jul)|(aug)|(oct)|(dec)))|(((30)|(29))((apr)|(jun)|(sep)|(nov)))|((2[0-8]|(1\d)|(0[1-9]))((jan)|(feb)|(mar)|(apr)|(may)|(jun)|(jul)|(aug)|(sep)|(oct)|(nov)|(dec)))))(((175[3-9])|(17[6-9]\d)|(1[89]\d{2})|[2-9]\d{3})|\d{2}))|((((175[3-9])|(17[6-9]\d)|(1[89]\d{2})|[2-9]\d{3})|\d{2})((((1[02])|(0[13578]))((3[01])|29))|(((11)|(0[469]))((30)|(29)))|(((1[0-2])|(0[1-9]))(2[0-8]|(1\d)|(0[1-9])))))|(((29feb)|(29[ \.\-/]feb(ruary)?[ \.\-/])|(feb(ruary)? 29,? ?)|(0?2[\.\-/]29[\.\-/]))((((([2468][048])|([3579][26]))00)|(17((56)|([68][048])|([79][26])))|(((1[89])|([2-9]\d))(([2468][048])|([13579][26])|(0[48]))))|(([02468][048])|([13579][26]))))|(((((([2468][048])|([3579][26]))00)|(17((56)|([68][048])|([79][26])))|(((1[89])|([2-9]\d))(([2468][048])|([13579][26])|(0[48]))))|(([02468][048])|([13579][26])))(0229)))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "18-feb 5411"
(define-fun Witness1 () String (str.++ "1" (str.++ "8" (str.++ "-" (str.++ "f" (str.++ "e" (str.++ "b" (str.++ " " (str.++ "5" (str.++ "4" (str.++ "1" (str.++ "1" ""))))))))))))
;witness2: "june 28, 1796"
(define-fun Witness2 () String (str.++ "j" (str.++ "u" (str.++ "n" (str.++ "e" (str.++ " " (str.++ "2" (str.++ "8" (str.++ "," (str.++ " " (str.++ "1" (str.++ "7" (str.++ "9" (str.++ "6" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (re.union (re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "c" (str.++ "h" "")))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" "")))) (re.opt (re.range "y" "y")))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "s" (str.++ "t" ""))))))(re.union (re.++ (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (re.opt (str.to_re (str.++ "o" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))) (re.++ (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))))))))(re.++ (re.range " " " ") (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (str.to_re (str.++ "2" (str.++ "9" ""))))))(re.union (re.++ (re.union (re.++ (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "i" (str.++ "l" "")))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" "")))) (re.opt (re.range "e" "e")))(re.union (re.++ (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (re.opt (str.to_re (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))) (re.++ (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))))(re.++ (re.range " " " ") (re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "9" "")))))) (re.++ (re.union (re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (re.union (re.++ (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" "")))) (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "c" (str.++ "h" "")))))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "i" (str.++ "l" "")))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" "")))) (re.opt (re.range "e" "e")))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" "")))) (re.opt (re.range "y" "y")))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "s" (str.++ "t" ""))))))(re.union (re.++ (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (re.opt (str.to_re (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))(re.union (re.++ (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (re.opt (str.to_re (str.++ "o" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))(re.union (re.++ (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))) (re.++ (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))))))))))))(re.++ (re.range " " " ") (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))))))(re.++ (re.opt (re.range "," ",")) (re.range " " " ")))(re.union (re.++ (re.union (re.++ (re.union (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))) (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))))(re.++ (re.range "-" "/") (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (str.to_re (str.++ "2" (str.++ "9" ""))))))(re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "1" ""))) (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))))(re.++ (re.range "-" "/") (re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "9" "")))))) (re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")))(re.++ (re.range "-" "/") (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")))))))) (re.range "-" "/"))(re.union (re.++ (re.union (re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (str.to_re (str.++ "2" (str.++ "9" ""))))(re.++ (re.union (re.range " " " ") (re.range "-" "/")) (re.union (re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "c" (str.++ "h" "")))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" "")))) (re.opt (re.range "y" "y")))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "s" (str.++ "t" ""))))))(re.union (re.++ (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (re.opt (str.to_re (str.++ "o" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))) (re.++ (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))))))))))(re.union (re.++ (re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "9" ""))))(re.++ (re.union (re.range " " " ") (re.range "-" "/")) (re.union (re.++ (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "i" (str.++ "l" "")))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" "")))) (re.opt (re.range "e" "e")))(re.union (re.++ (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (re.opt (str.to_re (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))) (re.++ (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))))))) (re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))))(re.++ (re.union (re.range " " " ") (re.range "-" "/")) (re.union (re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (re.union (re.++ (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" "")))) (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "c" (str.++ "h" "")))))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" "")))) (re.opt (str.to_re (str.++ "i" (str.++ "l" "")))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" "")))) (re.opt (re.range "e" "e")))(re.union (re.++ (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" "")))) (re.opt (re.range "y" "y")))(re.union (re.++ (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" "")))) (re.opt (str.to_re (str.++ "u" (str.++ "s" (str.++ "t" ""))))))(re.union (re.++ (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (re.opt (str.to_re (str.++ "t" (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))))(re.union (re.++ (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (re.opt (str.to_re (str.++ "o" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))(re.union (re.++ (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" "")))))))) (re.++ (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))) (re.opt (str.to_re (str.++ "e" (str.++ "m" (str.++ "b" (str.++ "e" (str.++ "r" ""))))))))))))))))))))))) (re.union (re.range " " " ") (re.range "-" "/"))) (re.union (re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (str.to_re (str.++ "2" (str.++ "9" "")))) (re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))))))))))(re.union (re.++ (re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "9" "")))) (re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" "")))) (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))))))) (re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "0" "0") (re.range "1" "9")))) (re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "o" (str.++ "c" (str.++ "t" ""))))(re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" ""))))))))))))))))))))) (re.union (re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "5" "")))) (re.range "3" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" "")))(re.++ (re.range "6" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))))) ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (re.union (re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" (str.++ "5" "")))) (re.range "3" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" "")))(re.++ (re.range "6" "9") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9")))))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.union (re.++ (re.union (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))) (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8")))))) (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (str.to_re (str.++ "2" (str.++ "9" "")))))(re.union (re.++ (re.union (str.to_re (str.++ "1" (str.++ "1" ""))) (re.++ (re.range "0" "0") (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9"))))) (re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "9" ""))))) (re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2")) (re.++ (re.range "0" "0") (re.range "1" "9"))) (re.union (re.++ (re.range "2" "2") (re.range "0" "8"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "0" "0") (re.range "1" "9"))))))))(re.union (re.++ (re.union (str.to_re (str.++ "2" (str.++ "9" (str.++ "f" (str.++ "e" (str.++ "b" ""))))))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "9" "")))(re.++ (re.union (re.range " " " ") (re.range "-" "/"))(re.++ (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.++ (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" ""))))))) (re.union (re.range " " " ") (re.range "-" "/"))))))(re.union (re.++ (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.++ (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "a" (str.++ "r" (str.++ "y" "")))))))(re.++ (str.to_re (str.++ " " (str.++ "2" (str.++ "9" ""))))(re.++ (re.opt (re.range "," ",")) (re.opt (re.range " " " ")))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (re.range "2" "2")(re.++ (re.range "-" "/")(re.++ (str.to_re (str.++ "2" (str.++ "9" ""))) (re.range "-" "/")))))))) (re.union (re.union (re.++ (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "0" ""))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" ""))) (re.union (str.to_re (str.++ "5" (str.++ "6" "")))(re.union (re.++ (re.union (re.range "6" "6") (re.range "8" "8")) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "7" "7") (re.range "9" "9")) (re.union (re.range "2" "2") (re.range "6" "6")))))) (re.++ (re.union (re.++ (re.range "1" "1") (re.range "8" "9")) (re.++ (re.range "2" "9") (re.range "0" "9"))) (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))) (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))))))) (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6")))))) (re.++ (re.union (re.union (re.++ (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9")))) (re.union (re.range "2" "2") (re.range "6" "6")))) (str.to_re (str.++ "0" (str.++ "0" ""))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "7" ""))) (re.union (str.to_re (str.++ "5" (str.++ "6" "")))(re.union (re.++ (re.union (re.range "6" "6") (re.range "8" "8")) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "7" "7") (re.range "9" "9")) (re.union (re.range "2" "2") (re.range "6" "6")))))) (re.++ (re.union (re.++ (re.range "1" "1") (re.range "8" "9")) (re.++ (re.range "2" "9") (re.range "0" "9"))) (re.union (re.++ (re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8")))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8"))))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))) (re.++ (re.range "0" "0") (re.union (re.range "4" "4") (re.range "8" "8")))))))) (re.union (re.++ (re.union (re.range "0" "0")(re.union (re.range "2" "2")(re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "8" "8"))))) (re.union (re.range "0" "0")(re.union (re.range "4" "4") (re.range "8" "8")))) (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5")(re.union (re.range "7" "7") (re.range "9" "9"))))) (re.union (re.range "2" "2") (re.range "6" "6"))))) (str.to_re (str.++ "0" (str.++ "2" (str.++ "2" (str.++ "9" ""))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
