;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Password=&quot;(\{.+\}[0-9a-zA-Z]+[=]*|[0-9a-zA-Z]+)&quot;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F7Password=&quot;0&quot;"
(define-fun Witness1 () String (seq.++ "\xf7" (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "0" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))))))))))
;witness2: "R\u00E0G<Password=&quot;A&quot;"
(define-fun Witness2 () String (seq.++ "R" (seq.++ "\xe0" (seq.++ "G" (seq.++ "<" (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "A" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "P" (seq.++ "a" (seq.++ "s" (seq.++ "s" (seq.++ "w" (seq.++ "o" (seq.++ "r" (seq.++ "d" (seq.++ "=" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))))))))))(re.++ (re.union (re.++ (re.range "{" "{")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "}" "}")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.range "=" "=")))))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
