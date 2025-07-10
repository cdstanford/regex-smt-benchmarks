;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00CB988888\u00C89038"
(define-fun Witness1 () String (str.++ "\u{cb}" (str.++ "9" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "8" (str.++ "\u{c8}" (str.++ "9" (str.++ "0" (str.++ "3" (str.++ "8" "")))))))))))))
;witness2: "951\u00A4937r8539"
(define-fun Witness2 () String (str.++ "9" (str.++ "5" (str.++ "1" (str.++ "\u{a4}" (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "r" (str.++ "8" (str.++ "5" (str.++ "3" (str.++ "9" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
