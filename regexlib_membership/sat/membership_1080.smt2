;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Password=&quot;(\{.+\}[0-9a-zA-Z]+[=]*|[0-9a-zA-Z]+)&quot;
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F7Password=&quot;0&quot;"
(define-fun Witness1 () String (str.++ "\u{f7}" (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "0" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))))))))))
;witness2: "R\u00E0G<Password=&quot;A&quot;"
(define-fun Witness2 () String (str.++ "R" (str.++ "\u{e0}" (str.++ "G" (str.++ "<" (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" (str.++ "A" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))))))))(re.++ (re.union (re.++ (re.range "{" "{")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "}" "}")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.range "=" "=")))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
