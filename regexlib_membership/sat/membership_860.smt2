;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:(?:04|06|09|11)\/(?:(?:[012][0-9])|30))|(?:(?:(?:0[135789])|(?:1[02]))\/(?:(?:[012][0-9])|30|31))|(?:02\/(?:[012][0-9])))\/(?:19|20|21)[0-9][0-9]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "09/28/1923"
(define-fun Witness1 () String (str.++ "0" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "8" (str.++ "/" (str.++ "1" (str.++ "9" (str.++ "2" (str.++ "3" "")))))))))))
;witness2: "02/29/2155q\u009D\u00F2"
(define-fun Witness2 () String (str.++ "0" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ "/" (str.++ "2" (str.++ "1" (str.++ "5" (str.++ "5" (str.++ "q" (str.++ "\u{9d}" (str.++ "\u{f2}" ""))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "0" (str.++ "4" "")))(re.union (str.to_re (str.++ "0" (str.++ "6" "")))(re.union (str.to_re (str.++ "0" (str.++ "9" ""))) (str.to_re (str.++ "1" (str.++ "1" ""))))))(re.++ (re.range "/" "/") (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (str.to_re (str.++ "3" (str.++ "0" ""))))))(re.union (re.++ (re.union (re.++ (re.range "0" "0") (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "9"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "/" "/") (re.union (re.++ (re.range "0" "2") (re.range "0" "9"))(re.union (str.to_re (str.++ "3" (str.++ "0" ""))) (str.to_re (str.++ "3" (str.++ "1" ""))))))) (re.++ (str.to_re (str.++ "0" (str.++ "2" (str.++ "/" ""))))(re.++ (re.range "0" "2") (re.range "0" "9")))))(re.++ (re.range "/" "/")(re.++ (re.union (str.to_re (str.++ "1" (str.++ "9" "")))(re.union (str.to_re (str.++ "2" (str.++ "0" ""))) (str.to_re (str.++ "2" (str.++ "1" "")))))(re.++ (re.range "0" "9") (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
