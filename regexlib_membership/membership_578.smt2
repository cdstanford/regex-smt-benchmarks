;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{2}-[0-9]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}|[0-9]{2}-[A-Z]{2}-[0-9]{2}|[A-Z]{2}-[0-9]{2}-[A-Z]{2}|[A-Z]{2}-[A-Z]{2}-[0-9]{2}|}|[0-9]{2}-[A-Z]{2}-[A-Z]{2}|[0-9]{2}-[A-Z]{3}-[0-9]{1}|[0-9]{1}-[A-Z]{3}-[0-9]{2}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "93-YTA-8"
(define-fun Witness1 () String (str.++ "9" (str.++ "3" (str.++ "-" (str.++ "Y" (str.++ "T" (str.++ "A" (str.++ "-" (str.++ "8" "")))))))))
;witness2: "54-78-QZ\u009E"
(define-fun Witness2 () String (str.++ "5" (str.++ "4" (str.++ "-" (str.++ "7" (str.++ "8" (str.++ "-" (str.++ "Q" (str.++ "Z" (str.++ "\u{9e}" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9")))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "A" "Z"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "A" "Z"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "0" "9"))))))(re.union (re.range "}" "}")(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ (re.range "-" "-") ((_ re.loop 2 2) (re.range "A" "Z"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ (re.range "-" "-") (re.range "0" "9"))))) (re.++ (re.range "0" "9")(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
