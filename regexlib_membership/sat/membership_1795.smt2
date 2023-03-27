;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[2][0]\d{2})$|^(([0-2]\d|[3][0-1])\/([0]\d|[1][0-2])\/[2][0]\d{2}\s([0-1]\d|[2][0-3])\:[0-5]\d\:[0-5]\d)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "28/11/2038\u00A021:06:03"
(define-fun Witness1 () String (str.++ "2" (str.++ "8" (str.++ "/" (str.++ "1" (str.++ "1" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "3" (str.++ "8" (str.++ "\u{a0}" (str.++ "2" (str.++ "1" (str.++ ":" (str.++ "0" (str.++ "6" (str.++ ":" (str.++ "0" (str.++ "3" ""))))))))))))))))))))
;witness2: "08/10/2001 02:22:46"
(define-fun Witness2 () String (str.++ "0" (str.++ "8" (str.++ "/" (str.++ "1" (str.++ "0" (str.++ "/" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ "1" (str.++ " " (str.++ "0" (str.++ "2" (str.++ ":" (str.++ "2" (str.++ "2" (str.++ ":" (str.++ "4" (str.++ "6" ""))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (str.to_re (str.++ "/" (str.++ "2" (str.++ "0" "")))) ((_ re.loop 2 2) (re.range "0" "9")))))) (str.to_re ""))) (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (str.to_re (str.++ "/" (str.++ "2" (str.++ "0" ""))))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
