;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[a-zA-Z][^>]*\son\w+=(\w+|'[^']*'|"[^"]*")[^>]*>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<R\u00F9\u00A9\u00A0on\u00B5=\"\u00C5\">\x10"
(define-fun Witness1 () String (str.++ "<" (str.++ "R" (str.++ "\u{f9}" (str.++ "\u{a9}" (str.++ "\u{a0}" (str.++ "o" (str.++ "n" (str.++ "\u{b5}" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{c5}" (str.++ "\u{22}" (str.++ ">" (str.++ "\u{10}" "")))))))))))))))
;witness2: "<h\u008F\u009B\x9onk=\"\">"
(define-fun Witness2 () String (str.++ "<" (str.++ "h" (str.++ "\u{8f}" (str.++ "\u{9b}" (str.++ "\u{09}" (str.++ "o" (str.++ "n" (str.++ "k" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ ">" "")))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "o" (str.++ "n" "")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "=" "=")(re.++ (re.union (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}"))) (re.range "'" "'"))) (re.++ (re.range "\u{22}" "\u{22}")(re.++ (re.* (re.union (re.range "\u{00}" "!") (re.range "#" "\u{ff}"))) (re.range "\u{22}" "\u{22}")))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}"))) (re.range ">" ">"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
