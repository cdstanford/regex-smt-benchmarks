;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \"[^"]+\"|\([^)]+\)|[^\"\s\()]+
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\"Q\"0t"
(define-fun Witness1 () String (str.++ "\u{22}" (str.++ "Q" (str.++ "\u{22}" (str.++ "0" (str.++ "t" ""))))))
;witness2: "\"a\xC\"\u0098"
(define-fun Witness2 () String (str.++ "\u{22}" (str.++ "a" (str.++ "\u{0c}" (str.++ "\u{22}" (str.++ "\u{98}" ""))))))

(assert (= regexA (re.union (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.+ (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}")))(re.union (re.++ (re.range "(" "(")(re.++ (re.+ (re.union (re.range "\u{00}" "(") (re.range "*" "\u{ff}"))) (re.range ")" ")"))) (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
