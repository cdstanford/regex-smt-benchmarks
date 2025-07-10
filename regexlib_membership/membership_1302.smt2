;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z]:(\\|(\\[^\\/\s:*"<>|]+)+)>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "J:\>"
(define-fun Witness1 () String (str.++ "J" (str.++ ":" (str.++ "\u{5c}" (str.++ ">" "")))))
;witness2: "O:\\u0087>;9\u00D5"
(define-fun Witness2 () String (str.++ "O" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{87}" (str.++ ">" (str.++ ";" (str.++ "9" (str.++ "\u{d5}" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range ":" ":")(re.++ (re.union (re.range "\u{5c}" "\u{5c}") (re.+ (re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "[")(re.union (re.range "]" "{")(re.union (re.range "}" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))))))))) (re.range ">" ">")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
