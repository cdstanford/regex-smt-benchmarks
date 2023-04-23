;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '('{2})*([^'\r\n]*)('{2})*([^'\r\n]*)('{2})*'
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x7\'\'\'\'\'\'\'\x1C\u00BAL\u00EF\'\'\'\'\'a"
(define-fun Witness1 () String (str.++ "\u{07}" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "\u{1c}" (str.++ "\u{ba}" (str.++ "L" (str.++ "\u{ef}" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "a" "")))))))))))))))))))
;witness2: "\'\'\'\'\'6\'\'\'\'\'\u0091<"
(define-fun Witness2 () String (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "6" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "'" (str.++ "\u{91}" (str.++ "<" ""))))))))))))))

(assert (= regexA (re.++ (re.range "'" "'")(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "&") (re.range "(" "\u{ff}")))))(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'")))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "&") (re.range "(" "\u{ff}")))))(re.++ (re.* ((_ re.loop 2 2) (re.range "'" "'"))) (re.range "'" "'")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
