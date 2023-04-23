;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0[289][0-9]{2})|([1345689][0-9]{3})|(2[0-8][0-9]{2})|(290[0-9])|(291[0-4])|(7[0-4][0-9]{2})|(7[8-9][0-9]{2})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9651\u00EE"
(define-fun Witness1 () String (str.++ "9" (str.++ "6" (str.++ "5" (str.++ "1" (str.++ "\u{ee}" ""))))))
;witness2: "2810"
(define-fun Witness2 () String (str.++ "2" (str.++ "8" (str.++ "1" (str.++ "0" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.range "0" "0")(re.++ (re.union (re.range "2" "2") (re.range "8" "9")) ((_ re.loop 2 2) (re.range "0" "9")))))(re.union (re.++ (re.union (re.range "1" "1")(re.union (re.range "3" "6") (re.range "8" "9"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "8") ((_ re.loop 2 2) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "0" "")))) (re.range "0" "9"))(re.union (re.++ (str.to_re (str.++ "2" (str.++ "9" (str.++ "1" "")))) (re.range "0" "4"))(re.union (re.++ (re.range "7" "7")(re.++ (re.range "0" "4") ((_ re.loop 2 2) (re.range "0" "9")))) (re.++ (re.++ (re.range "7" "7")(re.++ (re.range "8" "9") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
