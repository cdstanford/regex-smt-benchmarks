;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[A-ZÀ-Ü]{1}[a-zà-ü']+\s[a-zA-Zà-üÀ-Ü]+((([\s\.'])|([a-zà-ü']+))|[a-zà-ü']+[a-zA-Zà-üÀ-Ü']+))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "I\u00F0\u00E4\u00ED\x9o\u00D7\u00E8\'\x4"
(define-fun Witness1 () String (str.++ "I" (str.++ "\u{f0}" (str.++ "\u{e4}" (str.++ "\u{ed}" (str.++ "\u{09}" (str.++ "o" (str.++ "\u{d7}" (str.++ "\u{e8}" (str.++ "'" (str.++ "\u{04}" "")))))))))))
;witness2: "E\u00E1\u00E1\'\'\u00A0x\u00E3\u00E9\u00EE\'\u00A1"
(define-fun Witness2 () String (str.++ "E" (str.++ "\u{e1}" (str.++ "\u{e1}" (str.++ "'" (str.++ "'" (str.++ "\u{a0}" (str.++ "x" (str.++ "\u{e3}" (str.++ "\u{e9}" (str.++ "\u{ee}" (str.++ "'" (str.++ "\u{a1}" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "\u{c0}" "\u{dc}"))(re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\u{e0}" "\u{fc}"))))(re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))(re.++ (re.+ (re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{c0}" "\u{dc}") (re.range "\u{e0}" "\u{fc}"))))) (re.union (re.union (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "." ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\u{e0}" "\u{fc}"))))) (re.++ (re.+ (re.union (re.range "'" "'")(re.union (re.range "a" "z") (re.range "\u{e0}" "\u{fc}")))) (re.+ (re.union (re.range "'" "'")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{c0}" "\u{dc}") (re.range "\u{e0}" "\u{fc}")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
