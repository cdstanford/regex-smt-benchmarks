;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]\:|\\\\[^\/\\:*?"<>|]+\\[^\/\\:*?"<>|]+)(\\[^\/\\:*?"<>|]+)+(\.[^\/\\:*?"<>|]+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "v:\\u009A\x3\u00E0.\u00D6\u00C9"
(define-fun Witness1 () String (seq.++ "v" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\x9a" (seq.++ "\x03" (seq.++ "\xe0" (seq.++ "." (seq.++ "\xd6" (seq.++ "\xc9" ""))))))))))
;witness2: "v:\E\u009E_\\u00E1\u008C\u00AE.k"
(define-fun Witness2 () String (seq.++ "v" (seq.++ ":" (seq.++ "\x5c" (seq.++ "E" (seq.++ "\x9e" (seq.++ "_" (seq.++ "\x5c" (seq.++ "\xe1" (seq.++ "\x8c" (seq.++ "\xae" (seq.++ "." (seq.++ "k" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "\x5c" "")))(re.++ (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))(re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))))))(re.++ (re.+ (re.++ (re.range "\x5c" "\x5c") (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))))(re.++ (re.++ (re.range "." ".") (re.+ (re.union (re.range "\x00" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\xff"))))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
