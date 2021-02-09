;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0|[1-9]{1}[0-9]{0,8}|[1]{1}[0-9]{1,9}|[-]{1}[2]{1}([0]{1}[0-9]{8}|[1]{1}([0-3]{1}[0-9]{7}|[4]{1}([0-6]{1}[0-9]{6}|[7]{1}([0-3]{1}[0-9]{5}|[4]{1}([0-7]{1}[0-9]{4}|[8]{1}([0-2]{1}[0-9]{3}|[3]{1}([0-5]{1}[0-9]{2}|[6]{1}([0-3]{1}[0-9]{1}|[4]{1}[0-8]{1}))))))))|(\+)?[2]{1}([0]{1}[0-9]{8}|[1]{1}([0-3]{1}[0-9]{7}|[4]{1}([0-6]{1}[0-9]{6}|[7]{1}([0-3]{1}[0-9]{5}|[4]{1}([0-7]{1}[0-9]{4}|[8]{1}([0-2]{1}[0-9]{3}|[3]{1}([0-5]{1}[0-9]{2}|[6]{1}([0-3]{1}[0-9]{1}|[4]{1}[0-7]{1})))))))))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DE6915068"
(define-fun Witness1 () String (seq.++ "\xde" (seq.++ "6" (seq.++ "9" (seq.++ "1" (seq.++ "5" (seq.++ "0" (seq.++ "6" (seq.++ "8" "")))))))))
;witness2: "\u00A489"
(define-fun Witness2 () String (seq.++ "\xa4" (seq.++ "8" (seq.++ "9" ""))))

(assert (= regexA (re.union (re.range "0" "0")(re.union (re.++ (re.range "1" "9") ((_ re.loop 0 8) (re.range "0" "9")))(re.union (re.++ (re.range "1" "1") ((_ re.loop 1 9) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "-" (seq.++ "2" ""))) (re.union (re.++ (re.range "0" "0") ((_ re.loop 8 8) (re.range "0" "9"))) (re.++ (re.range "1" "1") (re.union (re.++ (re.range "0" "3") ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "6") ((_ re.loop 6 6) (re.range "0" "9"))) (re.++ (re.range "7" "7") (re.union (re.++ (re.range "0" "3") ((_ re.loop 5 5) (re.range "0" "9"))) (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "7") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "8" "8") (re.union (re.++ (re.range "0" "2") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.union (re.++ (re.range "0" "5") ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "6" "6") (re.union (re.++ (re.range "0" "3") (re.range "0" "9")) (re.++ (re.range "4" "4") (re.range "0" "8")))))))))))))))))) (re.++ (re.opt (re.range "+" "+"))(re.++ (re.range "2" "2") (re.union (re.++ (re.range "0" "0") ((_ re.loop 8 8) (re.range "0" "9"))) (re.++ (re.range "1" "1") (re.union (re.++ (re.range "0" "3") ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "6") ((_ re.loop 6 6) (re.range "0" "9"))) (re.++ (re.range "7" "7") (re.union (re.++ (re.range "0" "3") ((_ re.loop 5 5) (re.range "0" "9"))) (re.++ (re.range "4" "4") (re.union (re.++ (re.range "0" "7") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "8" "8") (re.union (re.++ (re.range "0" "2") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "3" "3") (re.union (re.++ (re.range "0" "5") ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "6" "6") (re.union (re.++ (re.range "0" "3") (re.range "0" "9")) (re.++ (re.range "4" "4") (re.range "0" "7")))))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
