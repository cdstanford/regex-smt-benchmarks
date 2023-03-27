;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <script.*/*>|</script>|<[a-zA-Z][^>]*=['"]+javascript:\w+.*['"]+>|<\w+[^>]*\son\w+=.*[ /]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x0<G=\"\"\"javascript:8\'>X\u009A"
(define-fun Witness1 () String (str.++ "\u{00}" (str.++ "<" (str.++ "G" (str.++ "=" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "\u{22}" (str.++ "j" (str.++ "a" (str.++ "v" (str.++ "a" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ":" (str.++ "8" (str.++ "'" (str.++ ">" (str.++ "X" (str.++ "\u{9a}" ""))))))))))))))))))))))))
;witness2: "</script>\xF\u00DA"
(define-fun Witness2 () String (str.++ "<" (str.++ "/" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ">" (str.++ "\u{0f}" (str.++ "\u{da}" ""))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "<" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.* (re.range "/" "/")) (re.range ">" ">"))))(re.union (str.to_re (str.++ "<" (str.++ "/" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ">" ""))))))))))(re.union (re.++ (re.range "<" "<")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'")))(re.++ (str.to_re (str.++ "j" (str.++ "a" (str.++ "v" (str.++ "a" (str.++ "s" (str.++ "c" (str.++ "r" (str.++ "i" (str.++ "p" (str.++ "t" (str.++ ":" ""))))))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.+ (re.union (re.range "\u{22}" "\u{22}") (re.range "'" "'"))) (re.range ">" ">")))))))))) (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "=") (re.range "?" "\u{ff}")))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (str.to_re (str.++ "o" (str.++ "n" "")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.* (re.union (re.range " " " ") (re.range "/" "/"))) (re.range ">" ">")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
