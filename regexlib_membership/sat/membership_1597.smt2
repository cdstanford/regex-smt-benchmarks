;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]\:|\\\\[^\/\\:*?"<>|]+\\[^\/\\:*?"<>|]+)(\\[^\/\\:*?"<>|]+)+(\.[^\/\\:*?"<>|]+)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "v:\\u009A\x3\u00E0.\u00D6\u00C9"
(define-fun Witness1 () String (str.++ "v" (str.++ ":" (str.++ "\u{5c}" (str.++ "\u{9a}" (str.++ "\u{03}" (str.++ "\u{e0}" (str.++ "." (str.++ "\u{d6}" (str.++ "\u{c9}" ""))))))))))
;witness2: "v:\E\u009E_\\u00E1\u008C\u00AE.k"
(define-fun Witness2 () String (str.++ "v" (str.++ ":" (str.++ "\u{5c}" (str.++ "E" (str.++ "\u{9e}" (str.++ "_" (str.++ "\u{5c}" (str.++ "\u{e1}" (str.++ "\u{8c}" (str.++ "\u{ae}" (str.++ "." (str.++ "k" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (str.to_re (str.++ "\u{5c}" (str.++ "\u{5c}" "")))(re.++ (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))(re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))))))(re.++ (re.+ (re.++ (re.range "\u{5c}" "\u{5c}") (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))))(re.++ (re.++ (re.range "." ".") (re.+ (re.union (re.range "\u{00}" "!")(re.union (re.range "#" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=")(re.union (re.range "@" "[")(re.union (re.range "]" "{") (re.range "}" "\u{ff}"))))))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
