;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((www|http)(\W+\S+[^).,:;?\]\} \r\n$]+))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http~Lc\u00EA3"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "~" (str.++ "L" (str.++ "c" (str.++ "\u{ea}" (str.++ "3" ""))))))))))
;witness2: "\x17www@\u0087\u00DC\u009E\u0080\x1A\u00BB\u00E4\x6\u00EF\u00EC\\u00DB\u00A9"
(define-fun Witness2 () String (str.++ "\u{17}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "@" (str.++ "\u{87}" (str.++ "\u{dc}" (str.++ "\u{9e}" (str.++ "\u{80}" (str.++ "\u{1a}" (str.++ "\u{bb}" (str.++ "\u{e4}" (str.++ "\u{06}" (str.++ "\u{ef}" (str.++ "\u{ec}" (str.++ "\u{5c}" (str.++ "\u{db}" (str.++ "\u{a9}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))) (re.++ (re.+ (re.union (re.range "\u{00}" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\u{a9}")(re.union (re.range "\u{ab}" "\u{b4}")(re.union (re.range "\u{b6}" "\u{b9}")(re.union (re.range "\u{bb}" "\u{bf}")(re.union (re.range "\u{d7}" "\u{d7}") (re.range "\u{f7}" "\u{f7}")))))))))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))) (re.+ (re.union (re.range "\u{00}" "\u{09}")(re.union (re.range "\u{0b}" "\u{0c}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "#")(re.union (re.range "%" "(")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "<" ">")(re.union (re.range "@" "\u{5c}")(re.union (re.range "^" "|") (re.range "~" "\u{ff}"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
