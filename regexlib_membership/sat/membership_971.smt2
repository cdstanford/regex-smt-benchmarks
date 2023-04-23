;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]?\d|1\d\d|2[0-4]\d|25[0-5]).){3}([1-9]?\d|1\d\d|2[0-4]\d|25[0-5])$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "93t0\x9248\xC255"
(define-fun Witness1 () String (str.++ "9" (str.++ "3" (str.++ "t" (str.++ "0" (str.++ "\u{09}" (str.++ "2" (str.++ "4" (str.++ "8" (str.++ "\u{0c}" (str.++ "2" (str.++ "5" (str.++ "5" "")))))))))))))
;witness2: "249\"5-42\xE168"
(define-fun Witness2 () String (str.++ "2" (str.++ "4" (str.++ "9" (str.++ "\u{22}" (str.++ "5" (str.++ "-" (str.++ "4" (str.++ "2" (str.++ "\u{0e}" (str.++ "1" (str.++ "6" (str.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.union (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
