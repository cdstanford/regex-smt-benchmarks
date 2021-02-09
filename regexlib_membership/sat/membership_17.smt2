;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((((0?[13578]|1[02])\/([0-2]?[1-9]|20|3[0-1]))|((0?[469]|11)\/([0-2]?[1-9]|20|30))|(0?2\/([0-1]?[1-9]|2[0-8])))\/((19|20)?\d{2}))|(0?2\/29\/((19|20)?(04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)|2000))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A6l\u00DB02/29/1920"
(define-fun Witness1 () String (seq.++ "\xa6" (seq.++ "l" (seq.++ "\xdb" (seq.++ "0" (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "9" (seq.++ "/" (seq.++ "1" (seq.++ "9" (seq.++ "2" (seq.++ "0" ""))))))))))))))
;witness2: "9/20/82m"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "/" (seq.++ "2" (seq.++ "0" (seq.++ "/" (seq.++ "8" (seq.++ "2" (seq.++ "m" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "1" "1")(re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "7" "8"))))) (re.++ (re.range "1" "1") (re.union (re.range "0" "0") (re.range "2" "2"))))(re.++ (re.range "/" "/") (re.union (re.++ (re.opt (re.range "0" "2")) (re.range "1" "9"))(re.union (str.to_re (seq.++ "2" (seq.++ "0" ""))) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.union (re.range "4" "4")(re.union (re.range "6" "6") (re.range "9" "9")))) (str.to_re (seq.++ "1" (seq.++ "1" ""))))(re.++ (re.range "/" "/") (re.union (re.++ (re.opt (re.range "0" "2")) (re.range "1" "9"))(re.union (str.to_re (seq.++ "2" (seq.++ "0" ""))) (str.to_re (seq.++ "3" (seq.++ "0" ""))))))) (re.++ (re.opt (re.range "0" "0"))(re.++ (str.to_re (seq.++ "2" (seq.++ "/" ""))) (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "1" "9")) (re.++ (re.range "2" "2") (re.range "0" "8")))))))(re.++ (re.range "/" "/") (re.++ (re.opt (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))) ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (re.++ (re.opt (re.range "0" "0"))(re.++ (str.to_re (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "9" (seq.++ "/" "")))))) (re.union (re.++ (re.opt (re.union (str.to_re (seq.++ "1" (seq.++ "9" ""))) (str.to_re (seq.++ "2" (seq.++ "0" ""))))) (re.union (str.to_re (seq.++ "0" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "0" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "2" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "4" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "5" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "6" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "2" "")))(re.union (str.to_re (seq.++ "7" (seq.++ "6" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "4" "")))(re.union (str.to_re (seq.++ "8" (seq.++ "8" "")))(re.union (str.to_re (seq.++ "9" (seq.++ "2" ""))) (str.to_re (seq.++ "9" (seq.++ "6" ""))))))))))))))))))))))))))) (str.to_re (seq.++ "2" (seq.++ "0" (seq.++ "0" (seq.++ "0" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
